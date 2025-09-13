-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Sep 13, 2025 at 03:55 PM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `techblog`
--

-- --------------------------------------------------------

--
-- Table structure for table `contacts`
--

CREATE TABLE `contacts` (
  `id` int(11) NOT NULL,
  `name` text NOT NULL,
  `phone_number` varchar(50) NOT NULL,
  `email` varchar(50) NOT NULL,
  `message` text NOT NULL,
  `date` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `contacts`
--

INSERT INTO `contacts` (`id`, `name`, `phone_number`, `email`, `message`, `date`) VALUES
(1, 'bhaumik', '4425616165', 'bhaumikpatel5522@gmail.com', 'test', '2025-09-09 00:00:00'),
(2, 'abhi modi', '06546545656', 'abhi12@gmail.com', 'test', '0000-00-00 00:00:00'),
(3, 'abhi modi', '06546545656', 'abhi12@gmail.com', 'test', '0000-00-00 00:00:00'),
(4, 'abhi modi', '06546545656', 'abhi12@gmail.com', 'test', '2025-09-09 00:00:00'),
(5, 'bhaumik patel', '08460564891', 'bhaumikpatel4190@gmail.com', 'hi', '2025-09-09 00:00:00'),
(6, 'abhi modi', '06546545656', 'abhi12@gmail.com', 'hiiiiiiiiiii', '2025-09-09 13:21:15'),
(7, 'abhi modi', '06546545656', 'abhi12@gmail.com', 'This is a test email sent from Flask-Mail!', '2025-09-10 00:43:27'),
(8, 'abhi modi', '06546545656', 'abhi12@gmail.com', 'hi', '2025-09-10 00:48:27');

-- --------------------------------------------------------

--
-- Table structure for table `posts`
--

CREATE TABLE `posts` (
  `id` int(11) NOT NULL,
  `title` text NOT NULL,
  `slug` varchar(30) NOT NULL,
  `content` text NOT NULL,
  `img_file` varchar(30) NOT NULL,
  `date` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `posts`
--

INSERT INTO `posts` (`id`, `title`, `slug`, `content`, `img_file`, `date`) VALUES
(1, 'let\'s go through Machine Learning.', 'machine-learning', 'Machine Learning (ML) is a subset of artificial intelligence (AI) that enables systems to learn from data and improve their performance on specific tasks without being explicitly programmed. It involves creating algorithms that identify patterns in data and make predictions or decisions based on those patterns. This approach is widely used in applications such as image recognition, speech processing, recommendation systems, fraud detection, and autonomous vehicles.', 'machine-learning.png', '2025-09-10 16:47:08'),
(2, 'This is the Era of AI. we should get into it.', 'artificial-intelligence', 'Artificial Intelligence(AI) refers to the development of computer systems capable of performing tasks that typically require human intelligence. These tasks include recognizing speech, making decisions, solving problems, and identifying patterns. AI encompasses a wide range of technologies, including machine learning, deep learning, and natural language processing (NLP).', 'artificial-intelligence.jpg', '2025-09-10 23:15:34'),
(3, 'what is data anlysis and why is it important?', 'data-analysis', 'Data Analysis is the systematic process of inspecting, organising, and interpreting Data to extract meaningful insights. It helps identify patterns, trends, and relationships within data, enabling informed decision-making. Used across various industries, Data Analysis supports businesses, researchers, and policymakers in making data-driven choices that enhance efficiency, accuracy, and strategic planning.\r\n\r\nNow why it is that important?\r\nData is everywhere, but without proper analysis, it’s just a collection of numbers and facts. Let’s look at why Data Analysis matters and how it impacts different industries. \r\n\r\na) Improved Decision-making: Helps organisations make informed, strategic decisions by analysing past trends and predicting future outcomes. \r\n\r\nb) Identifying Market Trends: Enables businesses to understand Customer Behaviour and market trends, allowing them to tailor products and services effectively. \r\n\r\nc) Optimising Operations: Streamlines processes, reduces costs, and improves efficiency. \r\n\r\nd) Risk Management: Detects potential risks and fraud, allowing organisations to take preventive measures. \r\n\r\ne) Enhanced Customer Experience: Personalises services and improves customer satisfaction by understanding and analysing customer data. ', 'data-analysis.png', '2025-09-10 23:34:35'),
(4, 'Understanding Train, Test and Validation Data in Machine Learning.', 'train-test-data', 'When developing a machine learning model, one of the fundamental steps is to split your data into different subsets. These subsets are typically referred to as train, test, and validation data. Each of these plays a crucial role in the process of building and evaluating a machine learning model. Let’s dive into what each of these terms means and why they are important.\r\n\r\nTrain Data :\r\nTraining data is the subset of the dataset used to train the model. This is where the model learns patterns, relationships, and features of the data. During training, the algorithm adjusts its parameters based on this data to minimize error and improve its predictions.\r\nPurpose: To fit the model.\r\nProcess: The model iteratively adjusts its parameters to better fit the training data, using algorithms like gradient descent.\r\nExample: If you’re building a model to predict house prices, the training data might include numerous examples of houses with known prices, along with their features like size, location, and number of bedrooms.\r\n\r\nTest Data:\r\nTest data is the subset of the dataset used to provide an unbiased evaluation of a final model fit on the training dataset. It is only used after the model has been trained (and validated).\r\n\r\nPurpose: To assess the final model’s performance and generalization to unseen data.\r\nProcess: Once the model has been trained and hyperparameters tuned, the test data is used to evaluate the model’s performance. This step is crucial to understand how the model will perform in the real world.\r\nExample: For the house price prediction model, the test data would be another separate subset of houses that the model hasn’t seen during training or validation, and their known prices would be compared against the model’s predictions.\r\n\r\nValidation Data:\r\nValidation data is used to tune the model’s hyperparameters and to provide an unbiased evaluation of the model while tuning. Hyperparameters are the aspects of the model that are not learned from the data but are set before the training process begins (e.g., learning rate, number of layers in a neural network).\r\n\r\nPurpose: To evaluate the model during training and assist in hyperparameter tuning.\r\nProcess: After each training iteration (or epoch), the model’s performance is evaluated on the validation set. This helps to prevent overfitting to the training data.\r\nExample: Continuing with the house price prediction example, the validation data would be a separate subset of house examples that are not seen by the model during training but are used to check the model’s performance and tune hyperparameters.\r\n', 'train-test.jpg', '2025-09-10 23:50:13'),
(5, 'What is Leave-One-Out Cross-Validation? Explained.', 'cross-validation', 'Cross-validation is a statistical method for evaluating models by partitioning data into subsets for training and testing. Instead of a single train-test split, it performs multiple rounds of validation using different portions of the data.\r\n\r\nThe purpose is to estimate how well your model will perform on unseen data. By repeatedly training and testing on different data subsets, cross-validation provides a reliable measure of model performance. It helps answer the question: “Will it generalize, or is it just memorizing?”\r\n\r\nThis technique is valuable when you have limited data because it maximizes the use of available data while providing robust estimates.\r\n\r\nWhat Is Leave-One-Out Cross-Validation?\r\nInstead of dividing your dataset into k folds, LOOCV creates as many folds as there are data points. Each observation gets its turn as a single-point test set while all remaining observations form the training set.', 'cross-validation.jpg', '2025-09-11 00:02:12'),
(6, 'Feature Engineering in Deep Learning and Self-Supervised Learning.', 'feature-engineering', 'Feature engineering has been the secret behind high-performing models, and also the difference between a mediocre and an excellent solution. However, things are a little different now that we have deep learning. Knowing that there are models out there that “learn everything from raw data” made some wonder if feature engineering is still relevant?\r\n\r\nThe short answer is yes, but not like how it used to be.\r\n\r\nNowadays, the role of feature engineering has evolved. Instead of hand-crafting features from scratch, people now shape how their data is structured and augmented before reaching the model.\r\n\r\nIn this article, we’ll take a look at how feature engineering adapts to modern modelling approaches.\r\n\r\nTabular Deep Learning\r\nModels like TabNet and FT-Transformer have made deep learning more viable for structured data. But raw tabular inputs still need preprocessing, for example:\r\n\r\nCategorical variables must be encoded\r\nMissing data still needs thoughtful imputation\r\nDomain-specific transformations still give models an edge.\r\n\r\nTime Series, NLP, and Hybrid Systems\r\nFeatures like:\r\n\r\nRolling averages and lags\r\nTF-IDF signals (hybrid NLP systems)\r\nExternal knowledge-based features\r\nstill add value, especially in data-sparse scenarios.\r\n\r\nEnd-to-end learning doesn’t mean no preprocessing, instead it just means different kinds of preprocessing. So knowing when and how to intervene upstream of the model is still a core skill.\r\n\r\nNew Roles in Modern ML\r\nFeature engineering nowadays is less about feeding models fully formed answers, and more about setting up the right environment for them to learn. In other words, it’s about designing how models learn their representations.\r\n\r\nPositional Features and Representation Design\r\nIn language and spatial data, positional encoding is a form of feature engineering. Transformers need clear positional information because they lack recurrence or convolution.\r\n\r\n', 'feature-engineering.jpg', '2025-09-11 00:11:37');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `contacts`
--
ALTER TABLE `contacts`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `posts`
--
ALTER TABLE `posts`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `contacts`
--
ALTER TABLE `contacts`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `posts`
--
ALTER TABLE `posts`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=18;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
