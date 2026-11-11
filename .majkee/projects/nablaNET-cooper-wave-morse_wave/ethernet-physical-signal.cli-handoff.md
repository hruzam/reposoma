---
title: Ethernet physical signal — CLI experiment and research handoff
date: 2026-11-07
author: Wave
status: draft for host discovery and bounded experiments; no host measurements performed
audience: local CLI lead, scoped researchers, implementer, independent reviewer
companion: ethernet-physical-signal.findings-fyi.md
---

# Ethernet physical signal — CLI handoff

## 0. Mission and first assignment

Find whether two computers can deliberately vary a physical property of their copper Ethernet signaling and detect that variation through software-accessible measurements, while ordinary packet communication continues. Also establish whether either endpoint exposes actual waveform samples, or only derived measurements.

Start with the equipment that exists. Do not assume additional instruments are necessary; do not assume software can unlock measurements that the silicon never exports. Find the narrowest testable path.

**First assignment:** execute Scope A, prepare the capability matrix from Scope B, and implement the passive logging portion of Scope C. Return evidence and the next executable experiment. Do not start by building an arbitrary waveform modem or a particle simulator.

No exact NIC, PHY, driver, firmware, cable, switch, or topology has been identified in this handoff. Generic vendor examples are not the user's hardware inventory. No control-to-measurement channel has been demonstrated. Read the companion FYI for the evidence limits.

## 1. What the user means

The user proposes a second stream resembling telegraph dots and dashes: encode information in a measurable property of the electrical signal, alongside ordinary data traffic. They also ask whether a physical disturbance can change any software-visible output, even without exporting the entire waveform.

Use conventional terms: physical-layer telemetry, PHY diagnostics, modulation/demodulation, system identification, sensitivity analysis, observability, and hardware-in-the-loop testing. Packet timing modulation is a separate control experiment. Analog computation is a later question.

Keep these claims separate:

| Claim | Evidence needed |
| --- | --- |
| A physical signal was changed | Documented transmitter control plus register readback, or an independent electrical measurement |
| A physical effect was observed indirectly | A reproducible receiver statistic changes under a controlled intervention; confounders are tested |
| An extra message was recovered | Previously unseen symbols decode above a predeclared baseline on held-out runs |
| Normal networking coexists | Concurrent packet-integrity, loss and useful-throughput measurements meet the predeclared tolerance |
| Raw waveform was captured | Voltage-related samples with documented sample timing, scaling and measurement point |
| The waveform performed useful arithmetic | A separately specified function, accuracy and complete cost comparison; outside the first experiment |

## 2. Hypothesis register

| ID | Hypothesis | Operational test |
| --- | --- | --- |
| H0 | The installed hardware exposes no usable control/observation pair for this purpose | Inventory interfaces and device documentation; classify inaccessible paths explicitly rather than claiming universal impossibility |
| H1 | A waveform-related measurement can be read repeatedly while the link operates | Log one documented measurement with units, update interval, missingness and link state |
| H2 | A documented transmitter setting produces a distinguishable receiver response | Randomized A/B trials, matched ordinary traffic, sham changes, independent test blocks |
| H3 | H2 can carry a small extra symbol stream alongside normal traffic | Preamble, training, held-out symbol sequences, receiver-only decoding, integrity and performance checks |
| H4 | Raw waveform samples are available through installed hardware | Verify documented capture path, scaling, bandwidth, timing, record length and live/offline mode |
| H5 | A measured channel/receiver model predicts the observed response | Fit on training runs; evaluate on held-out measured runs and perturbation conditions |

H1 does not prove H2. H2 does not prove waveform reconstruction. H3 does not prove independent or free bandwidth. H4 can fail while H1–H3 remain possible. A simulation alone proves none of the hardware hypotheses.

## 3. Working contract

- Work on the user's designated computers and link. Begin with read-only discovery. Existing authorization covers routine discovery and reversible experiments within this brief; do not add repeated confirmation prompts.
- Inspect repository instructions, state, git status and existing diffs before writing there. Preserve other agents' work. Do not push, publish, install firmware, or change global networking as an incidental step.
- Before a disruptive PHY test, verify a recovery path that does not depend on the tested link. If that prerequisite is missing, continue research, passive logging and modeling; report the blocked active test precisely.
- Use documented settings for the exact chip revision. Do not brute-force reserved registers or treat debug values for a different chip as portable commands.
- Keep a single writer for NIC configuration. Researchers may investigate in parallel; they must not concurrently modify the same port or its settings.
- Record settings before and after each mutation, and restore and verify the baseline after each test block. Some reads clear latched status: check semantics before polling a register.
- Use bounded runs, bounded files and explicit stop conditions. No indefinite capture, sustained error floods or unattended resets. Avoid payload captures when counters and test-stream sequence numbers answer the question.
- A missing privilege, unsupported API or absent tool is an observed limitation, not permission to bypass access controls. Record it and continue independent scopes.

## 4. Scope A — host inventory and physical topology

**Owner:** local CLI with access to the actual machines.

Produce one inventory per host and a physical topology diagram. Record OS, kernel, NIC PCI/USB identifier, subsystem ID, revision, driver, firmware if reported, PHY model/revision where discoverable, active link mode, cable path, cable length estimate, switches, routers, media converters and PoE.

Useful read-only Linux discovery commands, run on each host (not on an unrelated cloud workspace):

```bash
uname -r
ip -br link
lspci -nnk
lsusb
```

After selecting the actual wired interface, replace the example name below:

```bash
iface=enp3s0
ethtool -i "$iface"
ethtool "$iface"
ethtool -T "$iface"
ethtool -S "$iface"
ethtool --phy-statistics "$iface"
ip -s link show dev "$iface"
readlink -f "/sys/class/net/$iface/device/driver"
readlink -f "/sys/class/net/$iface/phydev"
```

Commands may be absent or unsupported. Capture stdout, stderr and exit status separately. Do not silently install packages. A PCI ID may identify an integrated MAC/NIC without revealing a separate PHY. A missing `phydev` sysfs link does not establish that no PHY exists or that all vendor telemetry is inaccessible.

Do not run cable tests, self-tests, forced-speed changes, driver reloads, firmware updates or register writes during this inventory. Do not run `ethtool -d` blindly: establish its device-specific register-read side effects first. Redact unrelated host details before exporting reports.

**Topology gate:** a switch terminates the physical link and generates a new waveform on its next port. A and B attached to the same switch do not observe one uninterrupted electrical channel. IP traceroute does not discover every layer-2 switch. Determine cabling and port ownership physically or from known inventory.

If switched, select a single segment that can be observed at both ends, or arrange an explicitly designated direct-link experiment. Do not replace the production network implicitly. Router/switch port telemetry can be a separate target only when that equipment is accessible and supports it.

**Deliver:** `inventory-A.json`, `inventory-B.json`, `topology.md`, discovery command logs, and an explicit list of unknowns.

## 5. Scope B — exact-device controls and sensors

**Owner:** PHY/driver researcher, using Scope A identifiers.

Investigate vendor datasheets, revision notes, driver source and current kernel interfaces. Quote only brief relevant text; preserve URL, revision/date, section and register/API identifiers. Confirm that a documented feature is reachable from this host, not merely present somewhere in the product family.

Search, where applicable, for MDIO/MMD management access, vendor register windows, standard and private diagnostics, SNR/SQI, mean-square error (MSE), peak MSE, symbol/CRC errors, cable reflectometry, equalizer diagnostics, ADC capture, test-pattern generation, loopback, transmit amplitude, slew/emphasis, and clock controls. This is a search checklist, not a claim that these controls exist on consumer NICs.

For every candidate fill this matrix:

| Field | Required answer |
| --- | --- |
| Device | Exact silicon and revision; how identified |
| Property | What electrical/internal quantity is controlled or measured |
| Interface | Exact API/register and supported access path through this NIC/driver |
| Operation | Read, write, capture, intrusive diagnostic, or passive measurement |
| Semantics | Units, quantization, range, averaging window, refresh period, reset/read-clear behavior |
| Link condition | Valid speed, live-link/offline restriction, pair/direction and test-mode requirements |
| Interference | Adaptation, gain control, traffic dependence, temperature, or host-load dependence |
| Reversibility | Original value, restoration method and verification |
| Evidence | Primary source, exact section, and status: documented / host-observed / inferred / unknown |

Treat internal DSP measurements as sensors. General CPU temperature, package power and interrupt timing are much less specific: admit them only as separately labeled indirect candidates with a causal model and controls. Do not infer waveform shape from any aggregate scalar without establishing identifiability.

Current Linux documentation includes `MSE_GET`. Do not invent an `ethtool` CLI option from the API name. Check the installed kernel, utility and driver. Some NIC management paths are mediated by the MAC/firmware and do not expose generic MDIO to userspace.

**Deliver:** `capabilities.md`, `sources.md`, a ranked list of at most three initial control/observation pairs, and exact reasons for rejected paths.

## 6. Scope C — passive logger and baseline

**Owner:** implementer after semantics are verified.

Implement the smallest collector for one promising receiver observable. Use the actual supported API; do not build a generic register framework first. Choose polling rate based on device refresh and access cost. Polling a slowly refreshed value faster does not create additional independent samples.

Each append-only observation must carry:

```json
{
  "run_id": "allocated-run-id",
  "host": "A-or-B",
  "interface": "actual-interface",
  "metric": "documented-metric-name",
  "value": null,
  "unit": "documented-unit-or-raw-code",
  "monotonic_ns": 0,
  "utc_timestamp": "actual-time",
  "read_duration_ns": 0,
  "status": "ok-or-explicit-error",
  "source": "actual-api-or-register"
}
```

This is a schema example, not an observation. Use explicit missing values; never replace failed reads with zero. Record software observation time separately from hardware measurement time, if the latter is available. MSE can be averaged across many symbols; do not relabel it as an ADC sample.

For counter metrics, store raw counters and derive deltas with documented reset/wrap handling. Include link speed/state and adaptation/retraining events. Log observer overhead: CPU time, collection gaps and read latency.

Collect bounded baseline blocks under: quiet link, stable low test traffic, stable higher test traffic, and a host-load control. Use synthetic test payloads and record their generation rate, packet sizes, direction and sequence integrity. Record offloads, interrupt moderation and energy-saving settings without changing them initially. Set durations after measuring refresh; a practical starting target is at least 100 fresh hardware updates per condition, within a finite declared runtime budget. Report when this is unattainable.

**Gate:** if no readable physical-layer observable exists, deliver that result and continue Scope E modeling or Scope F instrumentation design. Do not substitute packet timing and call it voltage measurement.

**Deliver:** collector source, `run.json`, raw `.jsonl` observations, baseline summary and an overhead estimate. Add focused parser/counter/missing-data tests only where the implementation needs them.

## 7. Scope D — controlled intervention and decoding

**Owner:** experiment lead; one writer on hardware configuration.

### D1. Detect a change before attempting communication

Choose a documented, reversible transmitter control and two valid settings for the exact device. Verify whether the control is supported during live traffic, whether changing it resets/retrains the PHY, and whether an unchanged-setting write itself has an effect. Test-mode-only settings are not automatically live-link modulation controls.

Write the experiment manifest before seeing the labeled outcomes: settings, metric, symbol/block duration, settling/guard time, read rate, traffic schedule, randomization seed, trial count, primary statistic, network tolerance and stop condition. Hash and retain it. Keep the controller's truth labels separate from receiver observations.

Use randomized A/B blocks rather than all A followed by all B. Begin with slow blocks long enough to include multiple fresh receiver updates after settling. Allow a small, capped pilot to estimate settling and variance; freeze the design before the validation runs. Split by complete run/session, not adjacent samples from the same averaged window.

Required controls:

- **Sham:** same control software, logging, messages and write count without changing the electrical setting, where documented writes are safe.
- **Traffic:** match payload rate, packet size and direction across A/B; log actual rather than intended rates.
- **Host load:** vary receiver/transmitter CPU load separately from the electrical setting.
- **Time drift:** interleave conditions and repeat on a fresh session; temperature/adaptation may drift.
- **Positive control:** verify the pipeline on synthetic labeled data and, separately, a documented hardware condition expected to affect the metric. Synthetic success alone is not sensor validation. If no suitable hardware positive control exists, report that limitation.

A register write plus readback establishes a setting change, not an independently measured voltage change. State what remains inferred from vendor documentation. If no live-link control exists, report a blocked D1; do not force a sequence of link failures to manufacture a success.

Analyze effect size, variability, confidence interval and repeatability. A permutation analysis must respect temporal/run blocks. Account for metric selection or freeze one primary metric. Report effect conditional on adaptation state and traffic. A null result is bounded by tested settings, measurement resolution, runtime and noise.

### D2. Recover a short symbol stream

Proceed only if D1 is repeatable. Use a preamble, explicit framing, known training symbols and a balanced randomized held-out payload. Let the transmitter encode 0/1 through the two verified settings. The receiver decoder must use only its allowed measurements, framing/training and previously fixed parameters. It must not consume the test sequence, controller log or a management message revealing symbol labels.

Compare against a majority/chance baseline and timing-only/sham decoders. Record bit errors, erasures, missed frames, confidence intervals and repeatability on separate runs. Account for autocorrelation; one long run is not thousands of independent confirmations. If trying multiple decoders, select on training/validation and retain a fresh final test.

### D3. Verify coexistence and total cost

During D2, keep ordinary synthetic packet transfer active. Measure useful application throughput, packet loss, retransmissions where applicable, payload/sequence integrity, latency distribution, PHY errors and link drops. Declare acceptable differences from baseline before validation. No application corruption observed is weaker than no PHY errors.

Report extra-stream net bits/s after framing, guards, training and repeats, plus CPU cost, register-access rate and error rate. Compare with carrying the same extra message in ordinary packets on the same setup. Show whether any benefit exists; a successful physical mechanism need not be efficient.

**Stop conditions:** loss of the independent recovery path, unplanned link drops, failure to restore baseline, unsafe/undocumented control behavior, or the declared loss/error/runtime bound. Preserve the partial run and report the reason. Continue unaffected research scopes.

**Deliver:** preregistered manifest, controller and receiver code, raw logs, held-out results, negative controls, restoration evidence, and a scope-limited verdict.

## 8. Scope E — modeling and simulation

**Owner:** modeling researcher; can start alongside A/B with explicit synthetic assumptions.

Use the least complex model that predicts the observation:

1. **E0: protocol and telemetry model.** A/B setting, assumed sensor response, sensor averaging/quantization, polling latency, missingness and noise. Test whether a slow dot/dash stream would remain distinguishable. Sweep parameter ranges; label every unmeasured value synthetic.
2. **E1: electrical/channel model.** Discrete-time waveform, attenuation/filtering, delay, reflections if relevant, noise and receiver response. In a linear approximation, `r[n] = h[n] * s[n] + noise[n]`. Add clipping, gain control or adaptation only where evidence justifies it.
3. **E2: observation model.** Explicitly implement the proposed measurement function `z[k] = g(window_of_r, receiver_state) + measurement_noise`. Model sampling windows and accessible outputs, not an omniscient simulator's internal state.
4. **E3: circuit/EM detail.** Use SPICE or a transmission-line/field solver for a specific unresolved electrical question, with component values or parameter bounds. Do not attempt whole-computer particle simulation.

Model the control separately from ordinary data: `s(t; payload, control)`. Test identifiability: can two different controls or physical waveforms produce the same exported measurement? If yes, do not claim a unique waveform reconstruction.

Important negative cases: automatic gain removes amplitude changes; sensor averaging removes short symbols; scalar quality cannot distinguish several disturbance types; traffic-dependent measurements create a false decoder; a switch terminates the waveform; and decoder access to truth labels creates a false success.

Validate simulation behavior against analytic special cases: zero intervention gives no label-dependent effect; fixed gain yields the expected scaling; averaging suppresses short changes as predicted; quantization below one code may erase a change. Verify outputs using an independent calculation where possible.

Once measured data exists, fit only on training runs and predict held-out measurements. Compare predicted direction, magnitude, time constant, uncertainty and failure conditions. Report mismatch instead of tuning to every run. Model runtime, peak memory and input/output volume; keep the first model practical on modest hosts.

**Deliver:** assumptions and parameter provenance, reproducible scripts, environment/seed, synthetic-versus-measured labels, plots, held-out model checks and a decision about which hardware test is informative next.

## 9. Scope F — raw capture / external instrumentation fallback

**Owner:** instrumentation researcher, after exact link mode is known.

First finish checking documented installed-hardware capture facilities. If absent, specify an optional acquisition setup rather than immediately recommending purchases. State differential bandwidth, sampling requirements for the question, input loading, isolation, measurement point, channel count, record depth and export/programming interface.

100BASE-TX's separate directional pairs can simplify the first capture. Gigabit copper uses simultaneous signaling in both directions on all pairs: a line probe does not separate local and remote signals automatically. Explain how directions would be separated or why the chosen measurement does not require separation.

For two instruments, specify a shared trigger/clock or a quantified alignment method. OS timestamps or NTP alone do not establish electrical sample-level synchronization. Do not propose generic grounded probes across Ethernet pairs or uncharacterized taps that change impedance.

Store actual raw samples and calibration metadata; distinguish intended DAC samples, a near-end line measurement and a far-end line measurement. Bound storage with `channels × samples_per_second × stored_bytes_per_sample × seconds`, including metadata overhead where material. Triggered short records are a valid first step; continuous streaming is a separate throughput requirement.

Specify decoding stages for the actual standard, or a clearly separate custom link. Custom DAC/ADC boards attached to USB can demonstrate waveform encoding but do not establish capabilities of stock Ethernet cards. Spare-pair or same-pair superposition requires its own wiring/coexistence study, including PoE and negotiated link mode.

**Deliver:** a measurement diagram, acquisition budget, programmatic capture contract, alignment/error budget, and the exact unanswered hypothesis the equipment would resolve.

## 10. Scope G — independent review

**Owner:** reviewer not responsible for the positive result.

Try to disprove the claimed mechanism. Check topology, chip revision, control semantics, sensor freshness, read-clear effects, hidden labels, sample autocorrelation, traffic/load confounds, instrument loading, unsupported-register assumptions and restoration. Distinguish an observed change from a recoverable extra stream and from a useful computing advantage.

Re-run one decisive held-out test if host access permits. Otherwise audit the artifacts and label the review as non-replicating. Preserve disagreements with the disputed assumption and evidence. Do not reconcile inconsistent results by averaging unrelated conditions.

**Deliver:** defect/risk list, supported claims, unsupported claims, reproduction status and the next discriminating experiment.

## 11. Researcher dispatch cards — use next, per scope

These are assignments for subsequent researchers or CLI agents; this document does not claim that any were launched. Dispatch independent source/model work in parallel only after providing the relevant inventory. Keep hardware mutation serialized.

### R1 — device and driver researcher (Scope B)

Input: A/B inventories and topology. Find exact chip-revision controls/measurements and their host access paths. Prioritize live-link MSE/SQI and documented transmitter settings. Return the capability matrix, primary citations and one viable or blocked experiment. Do not inherit the premise that a side stream exists.

### R2 — observability/modeling researcher (Scope E)

Input: the candidate measurement contract, update/averaging window and control semantics; mark missing values. Independently assess distinguishability, adaptation and confounders. Build a small synthetic model with explicit assumptions and failure cases. Return predicted detectable ranges, sensitivity bounds and the next useful measurement. Do not present simulation as hardware evidence.

### R3 — measurement implementer (Scopes C/D)

Input: verified API, exact valid settings, topology, baseline/recovery state and predeclared experiment. Implement append-only logging first, then sham/randomized trials. Keep labels out of receiver decoding. Return raw observations, run metadata, restored settings and held-out results. No undocumented register exploration.

### R4 — instrumentation researcher (Scope F)

Input: link standard, access points, missing measurements and acquisition budget. Investigate raw-capture facilities before external equipment. Return the least complex justified measurement setup, automation interfaces and error/storage budget. Do not equate packet capture with electrical capture.

### R5 — independent reviewer (Scope G)

Input: frozen manifest, raw data, code, analysis and claimed outcome. Attempt alternative explanations. Return a scoped verdict and one test that could overturn it. Preserve disagreement rather than smoothing toward consensus.

Every researcher reports: conventional name; what is already solved; documented limitations and open edges; what remains specific to this setup; evidence; confidence; and next action. Identify dates for volatile software support. Use primary sources for technical claims.

## 12. Records and decisions

Suggested layout inside the actual project, adapted to existing conventions:

```text
physical-signal/
  PROJECT_STATE.md
  DECISIONS.md
  capabilities.md
  sources.md
  inventory/
  experiments/<run-id>/
    run.json
    control-events.jsonl
    observations-A.jsonl
    observations-B.jsonl
    network-observations.jsonl
    analysis.md
    restoration.json
  models/
  reports/
```

Allocate collision-resistant run IDs. Preserve originals; derive analyses separately. Record units and monotonic clocks; use UTC for interchange and Europe/Prague when presenting local dates. Hash raw files after capture completion. Save source revision and the actual command/environment needed for reproduction, without copying credentials or unrelated packet payloads.

Choose a verdict per hypothesis: `supported on tested setup`, `not detected within tested bounds`, `blocked by access`, `unsupported by installed hardware`, `inconclusive due to confounding`, or `simulation only`. Keep hardware absence distinct from a driver/access limitation. Give the tested boundary with every negative result.

Required next reply from the executing lead:

1. Exact hardware and physical topology found.
2. Accessible controls/observables, with evidence.
3. What actually ran and where its raw output is recorded.
4. What did not run and the precise blocker.
5. Highest-value next experiment, with expected distinguishing outcomes.

## AI HANDOFF

**Goal:** Test software control and observation of copper Ethernet physical signaling, including indirect sensors and possible coexistence with normal traffic.

**Current state:** Research-backed experiment draft only; no user-host inventory or measurement exists here.

**Decisions made:** Inventory before hardware conclusions; distinguish raw samples, derived telemetry, packet timing, decoding and computation; allow later scoped researchers; serialize port mutations.

**Files changed:** This experiment brief and the companion FYI summary.

**Validation performed:** Draft checked for evidence boundaries, dependencies, confounders, bounded runs, restoration and receiver-label isolation. No hardware test or model execution performed.

**Open questions / risks:** Actual chips and topology, access to management registers, sensor refresh/averaging, valid live-link controls and receiver adaptation.

**Recommended next move:** Scope A on both hosts, then Scope B and a passive Scope C logger. Modeling can start with declared synthetic assumptions.

**Agent:** Wave
