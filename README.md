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

# 🛠 Framework Choice

### Why Flutter?

I chose **Flutter** because it enables fast cross-platform development with a rich widget library and excellent support for animations, making it well-suited for creating an engaging children's application.

Flutter's hot reload significantly accelerated UI iteration during development, while its declarative widget system made it straightforward to build reusable components such as the Story Card, Quiz Card, Read Button, and AI Buddy.

State management was implemented using **Provider** because it is lightweight, beginner-friendly, officially recommended by the Flutter ecosystem, and sufficient for the scale of this assignment.

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

# 🔄 Transition Between Audio and Quiz

The transition between story narration and quiz presentation is managed entirely through the application's Provider.

Flow:

1. User presses **Read Me Story**.
2. The Read button becomes disabled while narration is active.
3. The application waits for the Text-to-Speech engine to finish speaking.
4. Once narration completes successfully, the Provider updates the `showQuiz` state.
5. The Quiz Card appears using an `AnimatedSwitcher` animation.

This approach keeps the transition predictable and ensures the quiz is only displayed after narration has finished.

---

# 📄 Data-Driven Quiz

The quiz is designed to be data-driven rather than hardcoded into the UI.

Each quiz consists of:

- Question
- List of options
- Correct answer

Example:

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
The Quiz Card dynamically generates the option widgets by iterating over the options list.

Because of this implementation:
- Any question text can be displayed.
- Any number of answer options can be rendered without modifying the UI code.
- Only the underlying quiz data needs to change.

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

# 💾 Caching Approach

The current implementation uses local story text with Flutter Text-to-Speech, so no remote audio files are downloaded or cached.

If remote audio narration were introduced, I would:

- Download the audio once.
- Store it locally using `path_provider`.
- Save the local file path using `shared_preferences` or a lightweight local database.
- Play the cached version on subsequent requests instead of downloading again.

This would reduce network usage, improve startup time, and provide offline playback after the first download.

---

# ⚙️ Audio Loading & Failure Handling

### Loading

When the user presses **Read Me Story**:

- The Read button becomes disabled.
- A loading indicator is shown while narration starts.
- The user cannot trigger multiple narration requests simultaneously.

### Failure Handling

Basic error handling is implemented around Text-to-Speech operations.

If narration fails:

- The loading state is cleared.
- The Read button becomes enabled again.
- The application remains responsive and the user can retry playback.

This prevents the interface from becoming stuck in a loading state.

---

# 🚀 Performance Profiling & Optimization

<img width="1872" height="239" alt="image" src="https://github.com/user-attachments/assets/599edf92-0f55-4e3a-9198-a680099b4663" />

### Performance Profiling

The application was profiled using **Flutter DevTools** in **Profile mode**.

During profiling, I measured:

- Story narration startup
- Quiz transition
- Wrong answer shake animation
- Correct answer confetti animation

A brief frame-time spike was observed when starting Text-to-Speech narration and triggering the initial UI updates. This is expected due to the initialization of the TTS engine. After initialization, frame timings remained stable during quiz interaction and animations, providing a smooth user experience.

### Performance Profile

![Flutter DevTools Frame Timing](images/performance_profile.png)

### Optimizations Applied

To keep the application lightweight on mid-range Android devices, I:

- Used **Provider** so only dependent widgets rebuild.
- Split the UI into reusable widgets, reducing unnecessary rebuilds.
- Used lightweight implicit animations (`AnimatedSwitcher`, `AnimatedPositioned`) and a single `AnimationController` for the shake effect.
- Loaded story and quiz data locally, avoiding network latency.
- Disabled repeated button presses while narration is active.
- Kept the widget tree simple and avoided unnecessary complexity.

### Before / After

Before optimization:
- Confetti animation replayed whenever the widget rebuilt after a correct answer.
- The Read Story button could be pressed repeatedly during narration.

After optimization:
- Confetti plays only once per successful quiz completion.
- The Read Story button is disabled while narration is active.
- Only the quiz state resets when replaying the story, keeping the user experience smooth and consistent.

---

# 🤖 AI Usage & Judgment

AI tools were used as development assistants throughout this assignment.

## ChatGPT

Used for:

- Flutter architecture discussions
- Provider state management guidance
- Code reviews
- Debugging
- Animation ideas
- README preparation

## Gemini

Used for:

- Generating the AI Buddy illustrations (idle and happy expressions)

## AI Suggestion I Changed

One AI suggestion was to display the quiz inside a popup dialog after narration.

After implementing and testing this approach, I found that it interrupted the reading experience and felt less natural for children.

Instead, I redesigned the flow so the quiz appears directly within the page after narration, matching the provided wireframes more closely and providing a smoother user experience.

## What Didn't Work Initially

Initially, the confetti animation replayed every time the widget rebuilt because it was triggered directly during the widget's build method.

This was resolved by introducing a local state flag that ensures the confetti animation only plays once when the user answers correctly, preventing repeated celebrations during unrelated rebuilds.

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
