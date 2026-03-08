# Netflix_title_DA
# Netflix SQL Data Analysis

## Project Overview

This project analyzes Netflix’s catalog using SQL to uncover insights about content trends, genres, actors, and country distribution.
The goal is to simulate real-world business questions that a **data analyst** might be asked and answer them using PostgreSQL queries.
The project demonstrates practical SQL skills including data cleaning, aggregation, window functions, and string manipulation.

---

# Dataset
The dataset contains information about Netflix movies and TV shows.

**Main fields included:**

* Show ID
* Type (Movie / TV Show)
* Title
* Director
* Cast
* Country
* Date Added
* Release Year
* Rating
* Duration
* Genre
* Description
---

# Database Schema

```sql
CREATE TABLE netflix_title
(
    show_id      VARCHAR(5),
    type         VARCHAR(10),
    title        VARCHAR(250),
    director     VARCHAR(550),
    casts        VARCHAR(1050),
    country      VARCHAR(550),
    date_added   VARCHAR(55),
    release_year INT,
    rating       VARCHAR(15),
    duration     VARCHAR(15),
    listed_in    VARCHAR(250),
    description  VARCHAR(550)
);
```

---

# Business Questions Solved

### Content Overview

1. Count the number of Movies vs TV Shows
2. Find the most common rating for Movies and TV Shows
3. List all movies released in a specific year

### Content Distribution

4. Find the top 5 countries with the most Netflix content
5. Identify the longest movie on Netflix
6. Find content added in the last 8 years

### Director & Actor Analysis

7. Find all content created by a specific director
8. List TV shows with more than 5 seasons
9. Find the top 10 actors appearing in the most Indian Netflix movies
10. Count how many movies Salman Khan appeared in during the last 10 years

### Genre Analysis

11. Count the number of titles in each genre
12. List all movies categorized as documentaries

### Regional Analysis

13. Find the years with the highest Netflix content releases in India

### Data Quality Check

14. Identify titles without a director

### Content Classification

15. Categorize titles as **Good** or **Bad** based on keywords like *kill* or *violence* in descriptions

---

# SQL Skills Demonstrated

* Aggregation Functions (`COUNT`, `AVG`)
* Window Functions (`RANK`)
* Common Table Expressions (**CTE**)
* String Processing (`STRING_TO_ARRAY`, `UNNEST`)
* Conditional Logic (`CASE`)
* Date Functions (`TO_DATE`, `EXTRACT`)
* Filtering (`ILIKE`)
* Data Grouping and Ranking

---

# Example Insight

Some interesting findings from the analysis:

* Movies make up the majority of Netflix content.
* A small number of countries contribute a large portion of the catalog.
* Actor frequency analysis highlights the most common performers in Indian Netflix movies.
* Keyword-based classification reveals how many titles contain potentially violent descriptions.

---

# How to Run the Project

1. Import the dataset into PostgreSQL.
2. Create the table using the schema provided.
3. Run the SQL queries inside `netflix_analysis.sql`.
4. Explore the results of each business question.

---

# Tools Used

* PostgreSQL
* SQL
* Git
* GitHub

---

# Future Improvements

* Build interactive dashboards in Power BI or Tableau
* Perform deeper trend analysis by year
* Create visualizations for genre and country distribution
* Convert SQL analysis into a full data pipeline project

---
