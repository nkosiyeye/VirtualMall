# 🛍️ VMall - Flutter Virtual Mall Application

VMall is an **innovative and interactive virtual mall experience** built with **Flutter**. It allows users to explore stores, browse products, interact with vendors, and make purchases — all within one unified digital environment.  

![App Screenshot or GIF Demo of Mall Navigation/Store Interaction](./assets/demo.gif)

---

## 🎯 Project Goal
To create a **next-generation mobile shopping platform** where users can immerse themselves in a **virtual mall**, navigate through digital storefronts, and enjoy a seamless end-to-end shopping experience — from discovery to checkout.

---

## ✨ Features

### 🔐 User Authentication & Personalized Experience
- Secure **Email & Password** sign-up and login.  
- *(Optional)* Social logins (Google, Facebook, etc.) for quick onboarding.  
- Password reset functionality.  
- **User Profile**:  
  - Update personal information.  
  - View order history.  
  - Manage saved payment methods and shipping addresses.  
  - *(Optional)* Wishlist/Saved Items across stores.  

---

### 🏬 Virtual Mall Navigation & Store Discovery
- **Interactive Mall Map/Directory**: Visual mall layout or categorized directory of stores.  
- **Store Listings**: Browse by category (Fashion, Electronics, Food Court, Books, etc.).  
- *(Optional)* Highlight "New Arrivals" or "Popular Stores."  
- **Individual Storefronts**:  
  - Store banner/logo and branding.  
  - Store-specific categories and promotions.  
  - Featured products.  
  - *(Optional)* Store details: contact info, return policies.  

---

### 🛒 Product Browsing & Details
- **Product Catalogs** within each store.  
- **Detailed Product Pages**:  
  - High-resolution images with zoom/gallery.  
  - Name, description, and price.  
  - Variations (size, color, model).  
  - Stock availability.  
  - *(Optional)* Customer reviews and ratings.  
  - *(Optional)* Similar product recommendations.  
- Efficient loading with pagination or infinite scroll.  

---

### 🔎 Advanced Search Functionality
- **Global Mall Search**: Find products or stores mall-wide.  
- **In-Store Search**: Focused product search within a store.  
- **Filtering Options**:  
  - Category (mall-wide or in-store).  
  - Price range.  
  - Brand.  
  - *(Optional)* Product-specific attributes (size, color, rating).  
- **Sorting**:  
  - Price (Low → High / High → Low).  
  - Popularity.  
  - Newest arrivals.  
  - Ratings.  

---

### 🛍️ Shopping Cart & Checkout
- **Universal Cart**: Add products from multiple stores into a single cart.  
  *(Alternative: Individual store carts if checkout is store-specific — clarify in scope.)*  
- Manage items: update quantity, remove products.  
- **Secure Checkout Process**:  
  - Select or enter shipping address.  
  - *(Optional)* Choose shipping methods (delivery speed, cost).  
  - Payment method selection (Stripe, PayPal, Razorpay, etc.).  
  - Order summary and confirmation.  

---

### 📦 Order Management
- View complete order history.  
- Detailed order view: items, prices, shipping status, tracking.  
- *(Optional)* Live tracking updates.  
- *(Optional)* Return and exchange requests.  

---

### 🌟 Key Unique Virtual Mall Features
1. **🛋️ Interactive 3D Store Walkthroughs**  
   - Explore select stores in a **3D immersive environment**.  
   - Navigate virtually through aisles and displays.  

2. **💬 Live Chat with Store Representatives**  
   - In-app messaging with sales assistants.  
   - Get personalized product recommendations or clarifications.  

3. **🎉 Virtual Events & Promotions Hub**  
   - Dedicated space for **mall-wide sales events**.  
   - Announcements of **new store launches**.  
   - **Virtual fashion shows** or product demos.  

---

### 🔔 Push Notifications *(Optional)*
- Order status updates.  
- Promotions from favorited stores.  
- New arrivals in preferred categories.  
- Cart abandonment reminders.  

---

## 👥 Target Audience
- **Shoppers** who want a diverse digital mall experience.  
- Users seeking more **engaging and interactive shopping** than traditional e-commerce.  
- *(Optional)* **Vendors/Store Owners** managing their own digital storefronts.  

---

## 🛠️ Tech Stack
- **Flutter** – Cross-platform development.  
- **GetX** – State management, routing, and dependency injection.  
- **Firebase**:  
  - Authentication (Email/Password, Social Logins).  
  - Firestore (Database for stores, products, orders).  
  - Storage (Product/store images, banners).  
  - *(Optional)* Cloud Functions (backend logic like order processing, vendor tools).  
  - *(Optional)* App Check (for app integrity).  
  - *(Optional)* Cloud Messaging (Push notifications).  
- **Google Maps / Custom 3D SDK** *(Optional)* for store navigation.  
- **Payment Gateway** integrations (Stripe, PayPal, Razorpay, etc.).  
