# 🚗 Car Sales System

A web-based car sales management system developed using Java. This system provides role-based access and functionality for managing staff, salesmen, and customers, facilitating smooth car inventory management, sales processing, customer feedback, and analysis.

## 👨‍💻 Technologies Used

- Java
- JSP, Servlets
- MySQL
- HTML, CSS, JS for frontend
- GlassFish 
- Chart.js

---

## 🔐 User Roles

The system supports three distinct user roles:

- **Managing Staff**
- **Salesman**
- **Customer**

Each role has a tailored dashboard and access to specific modules relevant to their responsibilities.

---

## 🧩 Key Features

### 🔑 Authentication
- Role-based login for managing staff, salesmen, and customers
- New customer registration
- Profile editing and password management

### 🚗 Car Management (Managing Staff)
- Add, edit, delete car records
- Filter cars by availability status
- Car list management

### 📊 Payment Analysis (Managing Staff)
- View daily and monthly payment analytics by selecting month/year
- Visual charts and summaries

### 🗣 Feedback Analysis (Managing Staff)
- Analyze customer feedback and average ratings by car brand/model

### 👥 Staff Management (Managing Staff)
- Add/edit/delete staff profiles
- Auto-create staff user accounts

### 📅 Car Booking (Salesman)
- View list of available cars
- Book cars for specific customers

### 💵 Payment Processing (Salesman)
- View pending payments
- Accept payments and update balance

### 📈 View Sales Record (Salesman)
- Track unpaid or completed sales
- Add comments on sales transactions

### 🧾 Purchase History (Customer)
- View purchase records and payment statuses
- Submit car feedback and ratings

---

## 🧪 Demo Credentials

| Role           | Username   | Password |
|----------------|------------|----------|
| Managing Staff | `shiehrou` | `demo`   |
| Salesman       | `amy`      | `demo`   |
| Customer       | `ivy`      | `demo`   |

---

## 🚀 Getting Started

### Prerequisites
- JDK 8+
- Apache Tomcat or GlassFish
- MySQL database
