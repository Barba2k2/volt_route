# 🔧 Prompt definitivo — VoltRoute (Clean Arch + BLoC + Google Places + AI-Ready Docs)

**System / Role**
You are a senior **Flutter engineer** and **Clean Architecture** practitioner using **BLoC** for state management. Deliver a **production-ready EV trip planner** for iOS/Android and a **first-class AI-Ready documentation set** inside `/docs`.

**Operating Mode**

* Persist to completion; assume reasonable defaults and log them.
* Before each major step, print a short **plan/preamble** (what you’ll do, inputs, outputs).
* Run an internal **rubric** (Architecture, Code Quality, UX/A11y, Performance, Reliability, Tests, AI-Ready Docs). Iterate until it all passes.

---

## 1) Product Brief

**App (temp):** VoltRoute
**Users:** EV owners aged **35–60** (Tesla, Volvo, BYD etc.).
**Goal:** Plan trips with **charging stops** filtered by **vehicle compatibility**, showing **estimated SoC** on arrival to each stop and to the final destination.
**Modes:**

* **Quick trip (anonymous)**: plan without login.
* **Signed-in**: save routes, view **stats** (distance, kWh used, time charging vs driving, cost estimates).
  **UX:** Simple, elegant, **high contrast**, **light/dark themes**, legible sizing for 35–60.
  **Localization:** `pt-BR` default; structure ready for i18n.

---

## 2) Architecture (Clean Architecture + BLoC)

**Layering (strict one-way deps):**

* **domain/** (pure Dart)

  * `entities/`: `Vehicle`, `Charger`, `RoutePolyline`, `LegEstimate`, `Trip`
  * `value_objects/`: `Percentage`, `DistanceKm`, `EnergyKWh`, `SpeedKmh`, `DurationMinutes`
  * `repositories/` (abstract): `RoutingRepository`, `ChargingRepository`, `TripsRepository`, `AuthRepository`
  * `usecases/`: `PlanRoute`, `EstimateLegEnergy`, `GetCompatibleChargers`, `SaveTrip`, `GetSavedTrips`, `AuthenticateUser`
  * `failures/`: `NetworkFailure`, `AuthFailure`, `CalculationFailure`, `NotFoundFailure`

* **data/**

  * `models/` (DTOs + `fromJson/toJson`)
  * `datasources/remote/`: routing client, **Google Places** client (charging)
  * `datasources/local/`: `Isar`/`Sqflite` for saved trips + cache
  * `repositories_impl/`: implement domain repos, map errors, caching, retry/backoff

* **presentation/** (Flutter)

  * `features/`

    * `planning/` → `PlanningBloc`, views, widgets
    * `stop_details/` → `StopDetailsBloc`, view
    * `trips/` → `TripsBloc`, views
    * `auth/` → `AuthBloc`, views
  * `routes/` (`go_router`), `theme/` (tokens + typography), `l10n/`
  * **Rule:** No business logic in Widgets—only in BLoCs and use cases.

* **core/**

  * `di/` (get\_it/injectable), `network/` (Dio, interceptors, timeouts, retry), `errors/`, `config/` (env, flavors), `utils/` (math, formatters)

---

## 3) State Management (BLoC)

**PlanningBloc**

* **Events:** `OriginChanged`, `DestinationChanged`, `VehicleSelected`, `AssumptionsEdited(avgSpeed, reserveBufferPct)`, `PlanRequested`, `ReplanRequested`
* **States:** `Initial`, `Loading`, `PlanReady(route, stops, assumptions, notices)`, `Error(message)`

**StopDetailsBloc**

* loads selected charger, amenities, opening hours, pricing/cost hints

**TripsBloc**

* save/load/delete trips, expose list & summaries

**AuthBloc**

* sign-in/out, session restore; states: `Unauthenticated`, `Authenticating`, `Authenticated(user)`, `AuthError`

Use `equatable` for immutable states; isolate side-effects to BLoCs invoking **use cases** only.

---

## 4) External Integrations (Ports / Adapters)

* **RoutingProvider** (abstract): route polyline, distance, duration, (if available) max speed info.

  * Default impl can use **Google Directions API**.

* **ChargingProvider** (abstract): **charging stations along a route** for a given vehicle.

  * **Default implementation MUST use Google Places API** with `type=electric_vehicle_charging_station`.
  * Query strategy:

    1. Segment route polyline into windows;
    2. For each window, Places Nearby Search by lat/lng + radius;
    3. Merge/dedupe by `place_id`.
  * Return: `name`, `place_id`, `coords`, `vicinity/address`, `opening_hours.open_now`, `rating/user_ratings_total` (if available), **connector hints** if exposed, and **power (kW)** when present (often absent—document inference rules).
  * **Filtering:** by **connector** (CCS2/Type2/CHAdeMO/Tesla) from vehicle profile. When provider doesn’t expose connectors, apply a compatibility heuristic (brand/metadata/whitelist) and mark result as “assumed”.

* **Map SDK**: Google Maps Flutter plugin; render route polyline + **clustered** charger markers; tap → Stop Detail.

**Contracts**

```dart
abstract class ChargingProvider {
  Future<List<Charger>> chargersAlongRoute(RoutePolyline polyline, Vehicle vehicle);
}

abstract class RoutingProvider {
  Future<RoutePolyline> getRoute(Origin origin, Destination destination);
}
```

**Config & Quotas**

* All API keys via `.env`/flavors + `flutter_secure_storage`.
* Exponential backoff on quota limits; cache results for same polyline window.

---

## 5) Energy / SoC Estimation (Domain)

* **Inputs per leg:** distance, elevation gain (if available), **speed profile** (avg, cap by legal max), ambient temp (optional future), vehicle usable kWh, current SoC.
* **Model:** base Wh/km by vehicle; speed factor (>100 km/h increases consumption), grade factor (elev gain penalty), HVAC placeholder factor; **arrival floor/buffer** default **10–15%** (user configurable).
* **Charging time:** `ΔkWh / chargerPowerKW` with a **taper curve** >80%; cap max session time by user preference.
* **Outputs:** arrival SoC, kWh consumed, recommended charge kWh & minutes per stop; propagate to next leg.
* **Validation:** unit tests for edge cases (short hops, mountain legs, highway speeds, cold scenario placeholder).

---

## 6) UX / A11y

* **Typography** scale tuned for 35–60; dynamic type; WCAG AA contrast.
* Min tap target **≥ 44dp**; focus order & semantics labels.
* **Themes:** light/dark; design tokens; high-contrast palette.
* **Copy:** plain Portuguese; short labels.
* **States:** skeletons, meaningful errors (with recovery), offline banner, empty states with CTA.

**Primary Screens**

1. Home (origin, destination, vehicle, assumptions, “Plan Trip”).
2. Route Overview (map + stop cards: arrival SoC, kWh to add, minutes, amenities).
3. Stop Detail (Google Places data, address, open\_now, route-back link).
4. Trip Summary (distance, drive/charge time, energy, cost).
5. Saved Trips (list, duplicate, delete).
6. Profile/Vehicle (vehicle editor, auth, preferences).

---

## 7) Packages

`flutter_bloc`, `equatable`, `go_router`, `dio`, `get_it`/`injectable`, `isar` or `sqflite`, `flutter_secure_storage`, `intl`, `collection`, `logger`, optional `sentry_flutter`, Google Maps/Places/Directions plugins.

---

## 8) AI-Ready Documentation — `/docs`

**Create the following files** (with rich cross-links and real examples):

* `index.md` → entry point: overview, install, architecture, API, examples, AI notes, FAQ, changelog, contributing. (Use this as the central map for humans & AIs.)&#x20;
* `api.md` → **OpenAPI** for internal Facade endpoints (if any) and **external API usage notes** (Google Places/Directions): parameters, responses, example requests/responses. Provide **complete** specs and examples.&#x20;
* `ai-notes.md` → how agents should behave: safe ops, do/don’t lists, prompts, test tokens/fixtures, and CI notes to keep it updated.&#x20;
* `faq.md` → common questions (login options, privacy, connector compatibility assumptions, how SoC is computed).
* `ARCHITECTURE.md` → Clean Arch + BLoC diagrams, boundaries, naming, error handling, how providers are swapped.
* `contribuindo.md` → branching, PR template, testing policy, naming conventions, commit rules.
* `Changelog.md` → Keep a Changelog format (Added/Changed/Fixed, dates).

**Folder & governance expectations**

* Keep docs **inside `/docs`** with **clear structure** (index, api, ai-notes, faq, ARCHITECTURE, contribuindo, changelog). Automate checking & updates in CI/CD. &#x20;
* Use **Markdown estruturado**: titles, lists, tables, fenced code with language tags. Include **realistic examples**. Add **links cruzados** across files.  &#x20;
* Provide **contexto claro** (explain the “why” behind decisions).&#x20;

**Must-include examples**

* Curl to Google Places Nearby Search for `type=electric_vehicle_charging_station`.
* Example of route segmentation and merging results by `place_id`.
* OpenAPI snippet for our internal façade (if you wrap external calls).
* Example error payloads and retry/backoff notes.

---

## 9) CI/CD

* Pipelines: format, analyze, unit tests, BLoC tests, golden tests.
* **Docs checks**: broken links, presence of required files (`index.md`, `api.md`, `ai-notes.md`, etc.), and last-updated vs code changes (simple heuristic). (Automate & keep docs synced with code.)&#x20;
* Release notes → `Changelog.md`.

---

## 10) Deliverables

1. Flutter scaffold with structure above.
2. `pubspec.yaml` (pinned versions + rationale).
3. **Domain**: entities, VOs, repositories (abstract), use cases.
4. **Data**: DTOs, remote/local datasources, repo impls; **Google Places** charging provider; optional mock provider.
5. **Presentation**: BLoCs, views, widgets, routes, themes, l10n scaffold.
6. **Energy model** (unit-tested).
7. Auth (anonymous + sign-in) + persistence (saved trips).
8. CI (analyze, tests, docs checks).
9. `/docs/` AI-Ready set (with cross-links, real examples).
10. `README.md` (setup, env vars, how to get Google API keys, running).

---

## 11) Acceptance Criteria

* Runs iOS/Android, plans a mock route, lists **Google Places** charging stations filtered for vehicle compatibility (explicit vs inferred).
* Clean Architecture boundaries enforced; **BLoC** only in presentation.
* **SoC estimates** per leg/stop with adjustable assumptions & buffer.
* Anonymous flow + login flow; saved trips visible.
* **Docs** meet AI-Ready rules (structured Markdown, descriptive names, clear context, **real** examples, cross-links, OpenAPI). &#x20;
* CI green (code + docs).

---

## 12) Preamble the agent should output before coding

* **Assumptions** (vehicle catalog, default efficiency tables, taper curve, connector map).
* **Plan** (scaffold → domain → data with Places → presentation → tests → docs → CI).
* **Risks** (Places connector data often missing; mitigation via heuristics & user warnings).
* **Definition of Done** = All acceptance criteria + rubric pass.

---

## 13) Notes & Constraints

* Keep **domain pure**; no Flutter/HTTP types in domain.
* No business logic in Widgets.
* All network keys via env/flavors; **never** hard-code.
* Log assumptions in `ai-notes.md` and reference them from `index.md`.&#x20;
* Document reasoning for major decisions in `ARCHITECTURE.md` (context & why).&#x20;
