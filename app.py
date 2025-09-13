from flask import Flask,render_template,request,json,session,redirect
from flask_sqlalchemy import SQLAlchemy
from datetime import datetime
from flask_mail import Mail
from werkzeug.utils import secure_filename
import os

local_server=True
with open('config.json','r') as c:
    params=json.load(c)["params"]

app = Flask(__name__)
app.secret_key = params["secret_key"]
app.config['upload_folder'] = params["upload_location"]
app.config.update(
    MAIL_SERVER = 'smtp.gmail.com',
    MAIL_PORT = 465,
    MAIL_USE_SSL = True,
    MAIL_USERNAME = params["mail_username"],
    MAIL_PASSWORD = params["mail_password"]
)

mail=Mail(app)

if local_server:
    app.config['SQLALCHEMY_DATABASE_URI'] = params["local_uri"]
else:
    app.config['SQLALCHEMY_DATABASE_URI'] = params["prod_uri"]

db=SQLAlchemy(app)

class Contacts(db.Model):
    id = db.Column(db.Integer, primary_key=True)
    name = db.Column(db.String(80), nullable=False)
    phone_number= db.Column(db.String(15), unique=True, nullable=False)
    email = db.Column(db.String(30), unique=True, nullable=False)
    message = db.Column(db.String(120), nullable=False)
    date = db.Column(db.DateTime,default=datetime.now())

class Posts(db.Model):
    id = db.Column(db.Integer, primary_key=True)
    title = db.Column(db.String(80), nullable=False)
    slug= db.Column(db.String(30), unique=True, nullable=False)
    content = db.Column(db.String(200), unique=True, nullable=False)
    img_file = db.Column(db.String(30), nullable=False)
    date = db.Column(db.DateTime, default=datetime.now())

@app.route('/')
def home():
    posts = Posts.query.filter_by().all()
    #pagination
    page=request.args.get('page',1,type=int)
    #index for posts to show
    start = (page-1) * int(params["no_of_posts"])
    end = start + int(params["no_of_posts"])
    #posts that display on each page
    paginated_posts = posts[start:end]

    has_previous = page > 1
    has_next = end < len(posts)
    
    return render_template('index.html',params=params,posts=paginated_posts,page=page,has_previous=has_previous,has_next=has_next)

@app.route('/post/<string:post_slug>',methods=['GET'])
def post(post_slug):
    posts = Posts.query.filter_by(slug=post_slug).first()
    return render_template('post.html',params=params,posts=posts)

@app.route('/about')
def about():
    return render_template('about.html',params=params)

@app.route('/dashboard',methods=['GET','POST'])
def dashboard():
    posts = Posts.query.filter_by().all()

    if 'user' in session and session['user'] == params["admin_username"]:
        return render_template('dashboard.html',params=params,posts=posts)
    
    if request.method == 'POST':
        username=request.form.get('username')
        password=request.form.get('password')
        if username == params["admin_username"] and password == params["admin_password"]:
            session['user']=username
            return render_template('dashboard.html',params=params,posts=posts)    
    else:
        return render_template('login.html',params=params)

@app.route('/dashboard/add_post',methods=['GET','POST'])
def add_post():
    if 'user' in session and session['user'] == params["admin_username"]:
        if request.method == 'POST':
            title = request.form.get('title')
            slug = request.form.get('slug')
            content = request.form.get('content')
            img_file = request.form.get('img_file')

            post = Posts(title=title,slug=slug,content=content,img_file=img_file)
            db.session.add(post)
            db.session.commit()

    return render_template('add_post.html',params=params)

@app.route('/dashboard/edit_post/<int:post_id>',methods=['GET','POST'])
def edit_post(post_id):
    post=Posts.query.filter_by(id=post_id).first()

    if 'user' in session and session['user'] == params["admin_username"]:
        if request.method == 'POST':
            title = request.form.get('title')
            slug = request.form.get('slug')
            content = request.form.get('content')
            img_file = request.form.get('img_file')

            post.id=post_id
            post.title=title
            post.slug=slug
            post.content=content
            post.img_file=img_file
            post.date = datetime.now()
            db.session.commit()
            return redirect("/dashboard/edit_post/" + str(post_id))
        
    return render_template('edit_post.html',params=params,post=post)

@app.route('/dashboard/delete_post/<int:post_id>',methods=['GET','POST'])
def delete_post(post_id):
    post=Posts.query.filter_by(id=post_id).first()
    db.session.delete(post)
    db.session.commit()
    return redirect('/dashboard')

@app.route('/dashboard/upload_file',methods=['GET','POST'])
def upload_file():
    if 'user' in session and session['user'] == params["admin_username"]:
        if request.method == 'POST':
            if 'file' not in request.files:
                return "No file part in the request"
            
            file=request.files['file']

            if file.filename == '':
                return "No file selected."
            
            if file:
                filename = secure_filename(file.filename)
                file.save(os.path.join(app.config['upload_folder'],filename))
                return "file uploaded successfully"
            
    return render_template("/dashboard",params=params)
            

@app.route('/logout')
def logout():
    session.pop('user')
    return redirect("/dashboard")

@app.route('/contact',methods=['GET','POST'])
def contact():
    if request.method=='POST':
        name=request.form.get('name')
        email=request.form.get('email')
        phone_number=request.form.get('phone_number')
        message=request.form.get('message')

        contact=Contacts(name=name,email=email,phone_number=phone_number,message=message)
        db.session.add(contact)
        db.session.commit()

        mail.send_message('New message from '+ name,
                          sender=email,
                          recipients=[params["mail_username"]],
                          body=message
                        )

    return render_template('contact.html',params=params)

if __name__ == '__main__':
    app.run(debug=True) 
