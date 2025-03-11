Project Details ✈️
- I got the idea for ColorVision-App after talking to a friend with color blindness. He shared how difficult it can be to distinguish certain colors in everyday life—whether picking out clothes, reading signs, or choosing the right item at a store. That conversation got me thinking: What if there were a simple, offline tool to help?
I wanted to create something more than just another test—a real-time companion that helps users both check their vision and identify colors around them. That’s why I combined the Ishihara test for detecting color blindness with an AR-based color identifier, ensuring a seamless experience.
To achieve a smooth and efficient experience, I used ARKit, RealityKit, CoreImage, and SwiftUI:
ARKit & RealityKit (Live Camera Color Detection):
Enables real-time color recognition through the camera.
Provides lightweight AR processing without complex 3D models.
Works best on simple, distinct colors and may not handle highly complex images.
CoreImage (Photo-Based Color Detection):
Allows users to upload or capture an image.
Detects colors when users tap on an image, providing an intuitive way to analyze colors.
Optimized for simple, distinct color detection but may not perform well on highly detailed or blended images.
SwiftUI (Seamless User Experience):
Used to design a clean, intuitive interface that is simple to navigate.
Ensures smooth performance across different device sizes.
To align with the Swift Student Challenge requirements, I designed ColorVision-App to be fully offline and under 25MB. I did not incorporate AI models for color recognition. Instead, I leveraged native Apple frameworks to deliver a fast and reliable experience without external processing.
Currently, ColorVision-App is optimized for identifying simple, distinct colors, making it a reliable everyday tool. While it may not yet handle highly complex images, it provides quick and clear color recognition for those who need it most.
Ultimately, my goal is to make color identification effortless and fun, helping users navigate the world with confidence—no matter how they see it.
