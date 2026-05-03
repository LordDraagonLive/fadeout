# FadeOut MVP Decisions

## Product Definition

FadeOut is a Flutter-based sleep timer app that lets users set a countdown and
automatically pauses currently playing media using system media controls, with
fade-out, notification controls, dark UI, and basic built-in sleep sounds.

## Locked Decisions

| Area | Decision |
| --- | --- |
| App name | FadeOut |
| Brand | HelaGen product |
| Platform | Android-focused core, Android and iOS launch together |
| Core media action | Pause media first; if pause fails, try stop |
| Fade-out | Free basic fade-out; Pro unlocks advanced fade settings |
| Default fade | 60 seconds |
| Volume restore | Always restore original volume after pause/stop |
| Android setup guide | Short and optional during onboarding |
| Sleep sounds | 3 free sounds: rain, ocean, brown noise |
| Timer presets | 5, 10, 15, 30, 45, 60, 90 minutes |
| Custom timer | User can manually set any duration |
| Saved timer | One saved default timer in MVP |
| Monetization | Free + ads + Pro; subscription reserved for phase 2 or 3 |
| Pro price | USD 5.99 lifetime unlock |
| Subscription | USD 0.99 later, not MVP |
| Ads | Only on home/settings for non-Pro users without subscription |
| Backend | No real backend for MVP |
| Crash reporting | MVP only if needed; provider TBD |
| Purchase provider | TBD; keep provider-neutral boundary |
| Ad provider | TBD; keep provider-neutral boundary |

## iOS Store-Safe Wording

Use this wording or close variants:

> On iOS, media control depends on iOS and the currently playing app.

Avoid promising:

> Works with every iOS app.

## MVP Feature Scope

### Free

- Timer presets.
- Custom timer duration.
- Start, pause, resume, and cancel timer.
- Pause current media session when the timer ends.
- Try stop if pause fails.
- Basic 60-second fade-out.
- Restore volume after stopping media.
- Persistent timer notification.
- Notification actions:
  - Add 10 minutes.
  - Pause/resume timer.
  - Cancel timer.
  - Stop media now.
- Dark sleep-friendly UI.
- One saved default timer.
- 3 built-in sleep sounds:
  - Rain.
  - Ocean.
  - Brown noise.
- Short optional Android battery optimization guide.
- Ads only on home/settings.

### Pro Lifetime Unlock

- Remove ads.
- Advanced fade settings.
- More notification customization.
- Future unlimited routines/presets.
- Future premium UX features that do not require ongoing content.

### Future Subscription

Subscription is not part of MVP. Reserve it for features with ongoing value,
such as premium sound libraries, new sound packs, cloud sync, or sleep insights.
The purchase provider is intentionally undecided for now.

## Android MVP Behavior

Timer flow:

1. User starts timer.
2. Foreground service starts.
3. Persistent notification appears.
4. Countdown continues while the phone is locked.
5. Final 60 seconds fade volume down.
6. Send pause command to active media session.
7. If pause fails, try stop.
8. Restore original volume.
9. Timer completes.

Android responsibilities:

- Foreground service.
- Notification and notification actions.
- Media session control.
- Volume fade and restoration.
- Battery optimization state checks.
- Permission/setup guidance.

## iOS MVP Behavior

iOS responsibilities:

- Timer UI and local notifications.
- Built-in sleep sounds.
- Fade-out for in-app audio.
- Best-effort media command support where iOS allows it.
- Platform-safe messaging about limitations.

## Phase 2/3 Candidates

- Subscription.
- More sleep sounds and sound packs.
- Custom routines.
- Widgets.
- Android Quick Settings tile.
- iOS Lock Screen widget.
- Bedtime auto-start.
- Shake to extend timer.
- Sleep insights.
