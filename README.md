# Unsplashly

## Overview
Simple iOS app to search Unsplash photos, built using MVVM and Combine. Supports:
- Search bar
- Adaptive 2-column collection view with infinite scroll
- Per-image loading progress
- Detail view + save to photos album
- Offline caching of images 
- Multi-scheme support (DEV/STAGING/PRODUCTION)
- iOS 14+ (minimum)

## Architecture
MVVM pattern and clean architecture with modularization. Separated module (Core, Common, CommounUI)

## How to build
1. Open `Unsplashly.xcodeproj`
2. Select target scheme (`Unsplashly_Dev`, `Unsplashly_Staging`, `Unsplashly`)
3. Set a valid provisioning profile for the selected scheme (bundle id differs per scheme)

## Where I would improve with more time
- Add robust disk cache for images and persisted last-search results
- Deduplicate image download requests and implement cancellation
- Improve accessibility and animations
- Add more sophisticated UI (pinch-to-zoom detail view, pinch grid to change columns)
- Add placeholder skeleton views while loading
- Add sort/filter capability (based on color, date, orientation, etc.)
- Add to favorite capability

## Notes
- Unsplash usage: make sure to follow Unsplash API guidelines and attribution requirements.
- Info.plist: include `NSPhotoLibraryAddUsageDescription` for saving images.

## Screenshots
<img width="294" height="607" alt="Screenshot 2025-11-16 at 01 53 07" src="https://github.com/user-attachments/assets/f0409c86-67ad-494e-9048-9bc92e042c75" /><img width="291" height="609" alt="Screenshot 2025-11-16 at 01 54 02" src="https://github.com/user-attachments/assets/a8f0de12-e4af-407c-8ffa-fe3030321e7d" /><img width="293" height="608" alt="Screenshot 2025-11-16 at 03 33 14" src="https://github.com/user-attachments/assets/25834930-7653-4b42-b944-ce44182029e6" /><img width="284" height="601" alt="Screenshot 2025-11-16 at 01 53 19" src="https://github.com/user-attachments/assets/c65a2ecf-fc75-4f89-ab55-288b9d3c6fe3" /><img width="289" height="598" alt="Screenshot 2025-11-16 at 01 53 31" src="https://github.com/user-attachments/assets/d1f4317b-fcc4-432b-bd18-bc5ed2c76597" /><img width="287" height="604" alt="Screenshot 2025-11-16 at 01 53 40" src="https://github.com/user-attachments/assets/a7013023-2e12-428f-8f9f-baeb693202d5" /><img width="285" height="598" alt="Screenshot 2025-11-16 at 04 29 22" src="https://github.com/user-attachments/assets/8997d2e1-6439-48e8-aa91-e9e405200ff5" />
