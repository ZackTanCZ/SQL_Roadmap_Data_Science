# Free 6-Week SQL Roadmap for Data Science & Data Analytics

[![Subscribe DS Newsletter](https://img.shields.io/badge/Subscribe-DS%20Newsletter-orange)](https://tobeadatascientist.substack.com/)
[![LinkedIn](https://img.shields.io/badge/LinkedIn-Connect-blue)](https://www.linkedin.com/in/andresvourakis/)

I created this roadmap to guide you through mastering SQL basics in just **6 weeks** (or sooner if you have the time and are motivated) for free, focusing specifically on skills essential for aspiring **Data Scientists** or **Data Analysts**.

Here is what the roadmap looks like:

[Basic Level]

- **[Week 1](#week-1-learn-the-basics-of-sql-data-retrieval):** Learn the SQL basics and how to retrieve data.
- **[Week 2](#week-2-aggregations--group-by-summarizing-data):** Master aggregations and `GROUP BY` for data summarization.
- **[Week 3](#week-3-databases--joins-combining-data-sources):** Dive into relational databases and `JOINs` to combine datasets.

[Intermediate Level]

- **[Week 4](#week-4-learn-window-functions-optional-advanced-topic):** Learn Window Functions for advanced data manipulation.

[Advanced Level]

- **[Week 5](#week-5-learn-to-use-ctes-and-sub-queries):** Advance your skills with CTEs and sub-queries for complex queries.
- **[Weeks 6-7](#weeks-6-7-build-your-own-projects-hands-on-practice):** Build your own projects to apply everything you've learned.

### Want to really learn SQL?
Then don't just watch the tutorials and read the articles, practice every step of the way to ensure you gain a good understanding of the different concepts. You can use this [online SQL server](https://www.w3schools.com/sql/trysql.asp?filename=trysql_select_all) by W3Schools to practice SQL commands without needing to install anything. I also share other great [resources](#practice-sql) at the bottom of this respository.

Alright, let’s get started! 🚀

## Week 1: Learn the Basics of SQL (Data Retrieval)

Your first week is about understanding what SQL is and learning how to retrieve data from a database, which is essential for Data Science & Analytics.

- [x] **What is SQL?** [Youtube Video](https://www.youtube.com/watch?v=zsjvFFKOm3c)
- [x] **Install MySQL**: [Youtube Video](https://www.youtube.com/watch?v=wgRwITQHszU)
- **Basic Commands**:
  - [x] `SELECT` & `FROM`: [Youtube Video](https://www.youtube.com/watch?v=HYD8KjPB9F8)
  - 💡 `SELECT` is used to filter/choose table columns of interest
  - 💡 `FROM` is used to specify which table to query from
  - [x] `WHERE` & `LIKE`: [Youtube Video](https://www.youtube.com/watch?v=MARn_mssG4A)
  - 💡 `WHERE` is used to filter/choose rows of interest using condition(s)
  - 💡 `LIKE` is used to look for rows with a certain pattern ( use '%' or '_')

💡 **Tip:** You can start practicing what you just learned using the [online SQL server](https://www.w3schools.com/sql/trysql.asp?filename=trysql_select_all) by W3Schools.

💡 **Tip:** A typical SQL query is as follows
```
SELECT (column name)
FROM (table name)
WHERE (column name) LIKE (condition)
```
## Week 2: Aggregations & GROUP BY (Summarizing Data)

In your second week, you'll learn how to summarize data for insights using aggregation functions. This is critical for creating reports and dashboards.

- [x] **Aggregations (_COUNT, SUM, AVG, MAX, MIN_)**: [Youtube Video](https://www.youtube.com/watch?v=jcoJuc5e3RE)
- [x] **Using GROUP BY (_HAVING_ & _WHERE_)**: [Youtube Video](https://www.youtube.com/watch?v=nNrgRVIzeHg)
  - `WHERE` clause is used for non-aggregated columns
  - `GROUP BY` clause must match the `SELECT` clause
  - `ORDER BY` clause is used to sort the result
  - `HAVING` is used to filter aggregated columns

💡 **Tip:** When working with aggregations, start with smaller datasets to avoid performance issues and make debugging easier.


💡 **Tip:** A typical SQL query is as follows
```
SELECT (column name)
FROM (table name)
WHERE (condition)
GROUP BY (column name)
HAVING (condition)
ORDER BY (column name) 
```

## Week 3: Databases & JOINs (Combining Data Sources)

Understanding relational databases and mastering `JOINs` to combine tables is key for more complex analysis in Data Science & Analytics.

- [x] **What is a relational database?**: [Youtube Video](https://www.youtube.com/watch?v=OqjJjpjDRLc)
- [x] **Introduction to JOINs**:
    - [Youtube Video](https://www.youtube.com/watch?v=9URM1_2S0ho)
    - [Article](https://www.atlassian.com/data/sql/sql-join-types-explained-visually)
    - `Inner Join` `Left Join` are the most commonly used joins
      - `Left Join` and `Right Join` are interchangable.
      - Oddly enough mySQL workbench doesn't support `Right Join` and `Outer Join` 

💡 **Tip:** Practice `JOINs` with different types of datasets to understand how they combine data. Try to visualize what the result will look like before running the query.

💡 **Tip:** 

<img src="https://github.com/user-attachments/assets/d81f0d90-6deb-4c6f-a111-b66b5d42cdd0" width=50% height=50%>

Figure 1.2 - SQL Join visually explained credits to [Atlassian.com](https://www.atlassian.com/data/sql/sql-join-types-explained-visually)

## Week 4: Learn Window Functions (Optional Advanced Topic)

Now that you’ve mastered the basics of combining data with `JOINs`, you can take things to the next level by learning **window functions**. These are useful for **performing calculations** like ranking, running totals, or moving averages across subsets of data.

✋ **Note:** This section is more **advanced**. If you're still getting comfortable with basic SQL, feel free to skip this for now and return later.

- [x] **What are Window Functions?** [Youtube Video](https://www.youtube.com/watch?v=xFeOVIIRyvQ)
  - Windows are a subset of records
  - Windows Function perform calculations based on data in different groups of row
  - Windows Function is typically structured as follows: 
    ```
    windows_function(expression)
    OVER(
    [PARTITION BY partition_clause]
    [ORDER BY order_clause]
    )
    ```
  - `PARTITION BY` divides a table of records into **individual subsets** according to the partitional clause (determined by the column name), and applies the aggregate function across each subset.
  - `ORDER BY` (enclosed within OVER()) sorts the records found within each subset/partition by the order_clause (determined by the column name(s)) 
- [x] **Common Window Functions**:
  - `ROW_NUMBER()`, `RANK()` and `DENSE_RANK()`: [Youtube Video](https://www.youtube.com/watch?v=rIcB4zMYMas)
    - `ROW_NUMER()` assigns a sequential number to each record within the partition/window
    - `RANK()` behaves similarly to `DENSE_RANK()`, assigning a sequential number to each record within the partition/window. However, it skips the rank of tied rank. e.g. 5, 5, 7, 8, ...  
    - `DENSE_RANK()` behaves similarly to `RANK()`, assigns a sequential number to each record within the partition/window. However, it **does not** skips the rank of tied rank. e.g. 5, 5, 6, 7, ...
  - Window Functions Cheat sheet: [Article](https://www.datacamp.com/cheat-sheet/sql-window-functions-cheat-sheet)

💡 **Tip:** Check out how [5 real examples](https://tobeadatascientist.substack.com/p/5-powerful-ways-i-use-sql-window-functions) of how I use window functions as a Data Scientist in tech

## Week 5: Learn to use CTEs and sub-queries

In week 5, you’re now ready for multi-step queries. You’re really advancing in your SQL skills at this point, and you should be proud of yourself!

- **Learn about CTEs**: [Youtube Video](https://www.youtube.com/watch?v=_SanZ41uTlw)
- **Learn about sub-queries**: [Youtube Video](https://www.youtube.com/watch?v=GpC0XyiJPEo)

💡 **Tip:** When working with CTEs and sub-queries, break your queries down into smaller parts and test them individually before combining them.

## Weeks 6-7: Build Your Own Projects (Hands-on Practice)

Now that you have the foundational skills, it's time to apply them in real-world scenarios by working on projects.

- **Start with a guided project**: [Youtube Video](https://www.youtube.com/watch?v=JaUKDbCXMX4)
- **Ideas for your own projects**:
    1. **Customer Segmentation Analysis**
        - **Objective**: Analyze customer behavior and group them into segments based on purchasing habits.
        - **Dataset**: Use an open dataset like the [UCI Online Retail dataset](https://archive.ics.uci.edu/ml/datasets/online+retail) or any e-commerce dataset.
        - **Outcome**: Create distinct customer profiles (e.g., high-spenders, occasional buyers) and generate a report to inform marketing strategies.
        - **Difficulty**: Beginner to Intermediate

    2. **Movie Recommendation System (SQL-Based)**
        - **Objective**: Build a **simple** movie recommendation system based on user ratings.
        - **Dataset**: Use the [MovieLens dataset](https://grouplens.org/datasets/movielens/), which includes user ratings for movies.
        - **Outcome**: Generate a list of recommended movies based on user preferences and ratings patterns.
        - **Difficulty**: Intermediate to Advanced

💡 **Tip:** Take time to document your projects. Writing clear descriptions of the problem you’re solving and your approach will help solidify your understanding and build your portfolio.

## Practice SQL
Here are 5 great websites where you can practice SQL and keep your skills sharp

- [DataLemur](https://datalemur.com/sql-tutorial)
- [LeetCode](https://leetcode.com/problemset/database/)
- [SQLZoo](https://sqlzoo.net/)
- [HackerRank](https://www.hackerrank.com/domains/sql)
- [Mode Analytics SQL Tutorial](https://mode.com/sql-tutorial/)

💡 **Tip:** If you are unsure which one to choose, the [SQL 50](https://leetcode.com/studyplan/top-sql-50/) by LeetCode is usually a great starting point and DataLemur is specially great for practicing for DS/DA interviews.

## Additional Data Science Resources

 Here are some more resources to help you on your Data Science journey:

1. 📚 **[Data Scientist Handbook](https://github.com/andresvourakis/data-scientist-handbook)**: A curated list of resources (Free & Paid) to help data scientists learn, grow, and break into the field of data science.
2. 💌 **[To Be a Data Scientist (Newsletter)](https://tobeadatascientist.substack.com/)**: Weekly insights to break into Data Science and advance your career (**Join 2K+ Data Science already accelerating their careers**).

If you have questions or feedback send me a message through [here](https://www.linkedin.com/in/andresvourakis/). Enjoy!
