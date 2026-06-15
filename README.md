# 🤖 Peblo AI Story Buddy

A Flutter application developed as part of the **Peblo AI Story Buddy Internship Assignment**.

This app provides an engaging storytelling experience for children by narrating a story using Text-to-Speech (TTS) and then presenting an interactive quiz to reinforce comprehension through immediate visual feedback and playful animations.

---

## 🎥 Demo

[> **Demo Video:** *(Add your GitHub video link here after uploading the recording.)*](https://github.com/user-attachments/assets/8f343cbf-8aed-4406-b4dc-a5b23ac6111a)

The demo showcases:

* Story narration using Text-to-Speech
* Interactive AI Buddy
* Quiz generation after narration
* Wrong answer feedback
* Correct answer celebration
* Robot emotion change
* Confetti animation

---

# ✨ Features

* 📖 Interactive story display
* 🔊 Story narration using **flutter_tts**
* 🤖 AI Buddy with expressive emotions

  * Idle expression
  * Happy expression after correct answer
* ⏳ Loading and narration state handling
* 📝 Data-driven quiz rendered from structured data
* ❌ Wrong answer feedback

  * Red border
  * Cross icon
  * Haptic feedback
  * Shake animation
* ✅ Correct answer feedback

  * Green border
  * Check icon
  * Happy robot
  * Confetti celebration
* 🔄 Story can be replayed anytime without hiding the quiz, allowing children to listen again before answering
* 🎨 Kid-friendly (3D Toy Like Button) interface inspired by the provided Peblo wireframes

---

# 🏗️ Project Structure

```text
lib/
│
├── models/
│   └── quiz_model.dart
│
├── providers/
│   └── story_provider.dart
│
├── screens/
│   └── homepage.dart
│
├── services/
│   └── tts_service.dart
│
├── utils/
│   ├── app_colors.dart
│   └── app_data.dart
│
├── widgets/
│   ├── story_card.dart
│   ├── read_button.dart
│   └── quiz_card.dart
│
└── main.dart
```

The project follows a simple and beginner-friendly architecture by separating UI, business logic, models, services, and reusable widgets.

---

# 🛠 Tech Stack

* Flutter
* Dart
* Provider (State Management)
* flutter_tts
* confetti
* google_fonts

---

# 🧠 State Management

The application uses **Provider** for state management.

The provider manages:

* Story narration
* Loading state
* Quiz visibility
* Selected answer
* Correct / incorrect answer state
* Robot emotion state

Keeping the application state inside a single provider makes the UI reactive while maintaining a clean separation between presentation and business logic.

---

# 📄 Data-Driven Quiz

The quiz is rendered from structured data rather than hardcoded widgets.

Example structure:

```json
{
  "question": "What color was Pip's lost gear?",
  "options": [
    "Red",
    "Green",
    "Blue",
    "Yellow"
  ],
  "answer": "Blue"
}
```

The UI automatically builds the question and options from this data.

---

# 🔄 Application Flow

```text
Launch App
      │
      ▼
Display Story
      │
      ▼
User taps "Read Me Story"
      │
      ▼
Story narrated using Text-to-Speech
      │
      ▼
Quiz appears
      │
      │
      ▼             
Wrong Answer        
      │             
Shake Animation     
Red Border          
Cross Icon          
      │             
Try Again 
      │
      ▼
Correct Answer
      │
      ▼
Happy AI Buddy
Green Border
Check Icon
Confetti Celebration
```

---

# ⚙️ Loading & Error Handling

### Loading

* Read button is disabled while narration is in progress.
* Visual feedback indicates that the story is currently being read.

### Error Handling

Basic error handling is implemented for Text-to-Speech operations to prevent unexpected crashes and maintain a smooth user experience.

---

# 🚀 Performance Considerations

The application was designed to remain lightweight and responsive by:

* Using Provider to rebuild only necessary widgets.
* Separating widgets into reusable components.
* Keeping business logic outside the UI.
* Using simple animations with minimal overhead.
* Avoiding unnecessary widget rebuilds.

---

# 🤖 AI Usage

Artificial Intelligence tools were used as development assistants during this assignment.

### ChatGPT

Used for:

* Flutter development guidance
* Code reviews and improvements
* UI architecture suggestions
* Animation implementation
* State management guidance
* Debugging assistance
* README preparation

### Gemini

Used for:

* Generating the AI robot illustrations (idle and happy expressions)

All AI-generated suggestions, code, and assets were reviewed, understood, tested, integrated, and modified manually before being included in the final application.

---

# ▶️ Running the Project

Clone the repository:

```bash
git clone https://github.com/YOUR_USERNAME/peblo-ai-story-buddy.git
```

Navigate into the project:

```bash
cd peblo-ai-story-buddy
```

Install dependencies:

```bash
flutter pub get
```

Run the application:

```bash
flutter run
```

---

# 📦 Packages Used

| Package      | Purpose               |
| ------------ | --------------------- |
| provider     | State management      |
| flutter_tts  | Story narration       |
| confetti     | Celebration animation |
| google_fonts | Typography            |

---

# 📱 Platform

Tested on:

* Android

---

# 👨‍💻 Author

**Hemal Parmar**

Peblo AI Story Buddy Internship Assignment

Thank you for reviewing my submission!
