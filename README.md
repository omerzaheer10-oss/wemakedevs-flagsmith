# 🚀 Premium Checkout A/B Test

Built for the **WeMakeDevs Hackathon: A/B Testing & Experimentation Track**.

This is a cross-platform Flutter application that integrates **Flagsmith** to run a live A/B test on a premium subscription checkout screen.

## 📝 Overview
The goal of this experiment is to determine which pricing layout drives more checkouts. We are testing whether users are more likely to click "Continue to Payment" when presented with the Annual Plan first versus the Monthly Plan first.

## 🧪 The Experiment
We created a boolean feature flag in Flagsmith called `show_annual_plan_first`.

* **Control (True):** Displays the "Annual Power Plan" highlighted at the top as the default choice.
* **Variation (False):** Swaps the layout to display the "Monthly Pass" highlighted at the top.

The Flutter app fetches this flag asynchronously on startup and dynamically renders the UI based on the cloud configuration, requiring zero app updates to change the layout.

## 📊 Simulated Traffic & Analytics
As per the hackathon guidelines, traffic and user interactions are simulated.
When the "Continue to Payment" button is clicked, the app generates a unique user identity (e.g., `simulated_user_170000000_annual`) and fetches flags for that specific user. This registers the identity and their chosen plan layout directly in the Flagsmith dashboard, allowing us to track which UI variation drove the checkout event.

## 🛠️ Tech Stack
* **Frontend:** Flutter (Dart)
* **A/B Testing & Feature Flags:** Flagsmith SDK (`flagsmith: ^6.4.0`)

## 🎥 Demo Video
(https://drive.google.com/file/d/1GZnrT5dflIA12thSZOEG5xiQZd-6MriI/view?usp=sharing)

## 💻 How to Run Locally

1. **Clone the repository:**
   ```bash
git clone [https://github.com/omerzaheer10-oss/wemakedevs-flagsmith.git](https://github.com/omerzaheer10-oss/wemakedevs-flagsmith.git)
