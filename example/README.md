# Flutter Example

Run the Flutter app:

```bash
cd example
flutter create .
flutter pub get
flutter run
```

Notes:
- This hits the live API. Respect rate limits.
- Do not hotlink images; download and host them yourself.
- The app uses disk cache on mobile/desktop and localStorage on web.
- State management uses flutter_bloc (Cubit) with get_it for DI.
- UI images use cached_network_image.
- Example state classes use Freezed; run build_runner if you modify them.
