---

# 🌍 World Cup Database Project  

This project is designed to create and manage a relational database for World Cup data using **Bash scripting** and **PostgreSQL**. The aim is to automate data ingestion and query meaningful insights from the data, showcasing database design and scripting skills.  

---

## 🚀 Technologies Used  
- **PostgreSQL**: To design, manage, and query the database schema with constraints and relationships.  
- **Bash Scripting**: To automate the process of data insertion from CSV files into the database.  
- **SQL**: To perform advanced queries for extracting useful information from the dataset.  

---

## 📂 Features  

### 1️⃣ **Database Schema**  
- **Tables**:  
  - `teams`: Stores information about teams participating in the World Cup.  
  - `games`: Records game details like year, round, winner, and opponent.  
- **Relationships**:  
  - Foreign key constraints link games to teams for both winners and opponents.  

### 2️⃣ **Data Ingestion**  
- A **Bash script** reads the `games.csv` file, ensures uniqueness of teams, and dynamically populates the database.  
- Includes logic to handle duplicate entries and maintain data integrity.  

### 3️⃣ **SQL Queries**  
- Retrieve teams participating in specific rounds or years.  
- Explore relationships like game results and team performances.  

---

## 🔍 Example Query  

Retrieve a list of teams that played in the 2014 'Eighth-Final' round:  
```sql  
SELECT DISTINCT name  
FROM teams  
JOIN games ON teams.team_id = games.winner_id OR teams.team_id = games.opponent_id  
WHERE games.round = 'Eighth-Final' AND games.year = 2014;  
```  

---

## ⚠️ Limitations  
The dataset in `games.csv` is for practice purposes and is not comprehensive. However, this project provided a solid foundation for learning and implementing relational database concepts and scripting automation.  

---

## 📜 License  
This project was completed as part of the [freeCodeCamp Relational Database Certification](https://www.freecodecamp.org/learn/).  
Copyright © 2024 freeCodeCamp.  

---  
