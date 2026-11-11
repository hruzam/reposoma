---
title: Ethernet physical signal — findings, limits and next tests
date: 2026-11-07
author: Wave
status: FYI / evidence handoff; user hardware not inspected
companion: ethernet-physical-signal.cli-handoff.md
---

# FYI — what Wave found, what remains open

## 1. Question and present position

Majkee asks whether two copper-connected computers can use the electrical waveform itself: control some aspect of its shape, read physical effects programmatically, preserve measurements at both ends, and possibly carry a dot/dash-like stream alongside ordinary networking. Useful numerical computation is a possible later objective, not an established result.

**Present position:** physical waveform encoding and decoding are feasible in general. Some Ethernet PHYs expose software-controlled electrical settings and internal quality measurements. Whether the user's computers provide a usable control/measurement path remains unknown.

We have not identified or accessed the user's NICs, PHYs, drivers, firmware or cable topology. No hardware experiment, extra-stream transmission, waveform recording or device simulation has been performed in this conversation. The attached draft enables those next steps; it is not their result.

## 2. Findings with evidence status

| Finding | Status | Implication and limit |
| --- | --- | --- |
| Ethernet PHYs internally convert, shape and recover electrical signaling | Documented; [S1] | Physical processing exists inside the device; host software access to every internal signal does not follow |
| Stock packet interfaces expose decoded data rather than line-voltage recordings | Architecture/interface distinction; [S1], [S2] | Packet capture does not preserve the electrical waveform or every disturbance |
| Some PHYs provide programmable transmitter amplitude | Concrete documented example; [S3] | Software can affect an electrical property on some silicon; not proof of arbitrary waveform generation or access through the user's NIC |
| Some PHYs expose per-channel receiver MSE | Concrete documented example; [S4], [S5] | Electrical disturbances might be observable while decoded payloads remain correct |
| Linux documents an MSE diagnostic interface | Documented API; [S2] | Installation-specific kernel, driver and userspace support must be checked; no universal CLI command is asserted |
| Some drivers/PHYs export cable reflection measurements | Documented; [S2], [S6] | Raw TDR means reflected diagnostic pulses, not general continuous waveform export |
| External electrical acquisition can be automated | Documented instrument route; [S7], [S8] | A CLI can operate instruments and download samples, but the instrument supplies the analog observation |
| Gigabit copper carries both directions on every pair | Documented; [S9] | A simple line recording does not automatically separate transmitter and receiver waveforms |

### Specific examples worth investigating

**Transmit control:** the Analog Devices 78Q2120C lists register-programmable transmit amplitude and a PCS-bypass symbol interface. It is marked obsolete. It is evidence that these categories of access exist, not a purchase recommendation or identification of the installed hardware. Its PCS bypass also does not imply access through an ordinary desktop driver. [S3]

**Receiver observation:** TI's DP83867IR/CR June 2026 datasheet documents MSE registers at `0x0225`, `0x0265`, `0x02A5` and `0x02E5`, with speed restrictions and indirect register access. These addresses are specific to that device documentation. Do not write them into an unknown NIC or assume the same interpretation on another PHY. MSE is an internal quality statistic, not a line-voltage sample or direct reconstruction of waveform shape. [S4]

**Linux path:** the kernel's `MSE_GET` documentation describes per-channel snapshots, supported metrics, scale information, refresh information and symbols per hardware sample. These properties are exactly what a proposed decoder would need to understand. The documented API alone does not establish that either user host can use it. [S2]

## 3. Correction to the earlier investigation

The first answer reasonably distinguished stock networking from programmable analog hardware, but its investigation was insufficient to settle every indirect software observation route. The later question correctly exposed that gap.

The narrower conclusion is:

> Lack of a general raw-waveform interface does not imply that software cannot control an electrical setting or observe a physical effect through internal diagnostics.

Do not turn that correction into the opposite overclaim. We have found examples in other silicon and documented APIs. We have not found a working channel on these particular computers.

## 4. What may work; what has not been established

### Positive possibilities

- A receiver's MSE/SQI or similar internal diagnostic could act as a low-rate sensor.
- A documented transmitter setting could provide a controllable physical intervention.
- With a suitable pair, a deliberately slow two-state signal might be distinguishable even though normal packet contents remain unchanged. This is a hypothesis, not a demonstration.
- Measurements can be logged as samples, register values or events and processed by ordinary CLI programs. Preserve the type and timing of each observation.
- A custom DAC/ADC interface can demonstrate waveform encoding or analog integration if the installed Ethernet hardware has no appropriate access. It answers a different hardware question.

### Limits and possible negative results

- The installed NIC may expose no useful PHY diagnostics, even when its silicon has internal sensors.
- The management path may require driver work or be mediated by inaccessible firmware.
- A setting may be available only in compliance-test mode, require retraining, or have no documented live-link behavior.
- Automatic gain/equalization may compensate away an amplitude change; the visible statistic may remain constant or respond only transiently.
- A statistic can average away short pulses, be quantized too coarsely, or update too slowly for the proposed resolution.
- Aggregate quality can respond to traffic, host behavior, adaptation and temperature; observing correlation is not yet evidence of the proposed electrical mechanism.
- Extra signaling may cause errors rather than coexist usefully. Spare packet throughput does not establish spare electrical spectrum.
- Demonstrating a physical effect does not establish a competitive data channel or computing accelerator.

## 5. The topology issue

An Ethernet switch terminates a link's physical signaling and transmits a new signal on another link. IP routing also does not preserve an incoming copper waveform. Therefore, computers on the same home router/switch are not automatically the endpoints of one uninterrupted analog channel.

Investigate the actual segment: computer-to-switch, switch-to-computer, or a separately arranged direct connection. Do not mistake a successful switched-network packet transfer for successful waveform propagation across all hops.

100BASE-TX uses two pairs; 1000BASE-T uses four. Spare-pair proposals depend on the active standard, wiring and power delivery, and require additional transceivers. They are not automatically a stock-NIC feature. [S10]

## 6. Modeling: the user's disturbance intuition

The useful question is whether an intervention changes an accessible output by a distinguishable amount. Use a model of the control, channel, receiver and exported sensor:

`transmitter control + payload → electrical signal → channel/receiver → accessible measurement`

Three levels must be separated:

| Level | Question |
| --- | --- |
| Physical response | Did some internal electrical state change? |
| Observability | Did a software-readable output retain evidence of that change? |
| Recoverability | Can the receiver reliably distinguish intended symbols despite noise, drift and averaging? |

A whole-computer particle simulation is not needed to begin. A channel/receiver model and a sensor averaging/quantization model can test the relevant constraints. Circuit or electromagnetic detail is useful only for a specific unresolved question with realistic parameters.

Even a perfect forward model does not guarantee a unique inverse: many waveforms can produce the same decoded bytes or the same scalar MSE. Raw samples also have finite bandwidth, resolution and calibration. Do not describe an aggregate metric as a complete waveform cache.

For the cable itself, a linear model gives convolution with its impulse response. That is a physical transformation, but useful programmability or a numerical advantage must be specified and tested separately. The earlier analog-integration example placed the useful accumulation in a receiver circuit; it was not a demonstrated stock-Ethernet computation.

## 7. Decisive next tests

| Order | Test | What it resolves |
| --- | --- | --- |
| 1 | Inventory both hosts and actual cabling | Which devices and physical segments can be investigated |
| 2 | Map exact-device controls and exported measurements | Whether a control/observation pair is accessible |
| 3 | Repeated passive reads with documented freshness and semantics | Whether the proposed sensor produces usable observations |
| 4 | Randomized controlled intervention plus sham/load/traffic controls | Whether observed change follows the intended physical intervention |
| 5 | Receiver-only decoding of held-out symbols | Whether observations carry recoverable additional information |
| 6 | Concurrent packet integrity and performance checks | Whether normal networking coexists within a declared tolerance |
| 7 | Independent repetition and model prediction | Whether the result generalizes beyond one run and fits the mechanism |

Raw electrical instrumentation is a separate branch when direct samples are necessary or internal telemetry cannot answer the question. Its scope should name the missing observation before selecting equipment.

Acceptable negative outcomes include an access limitation, absent installed-hardware support, a null effect within stated test bounds, or an inconclusive result due to confounders. None establishes that all copper-based physical signaling is impossible.

## 8. Sources inspected

These primary sources were inspected during the conversation on 2026-11-07. Source-backed statements above are documentation findings, not host validation. Recheck the exact device revision and installed software before implementation. Mutable documentation can change after this date.

- **[S1] TI TLK110 datasheet, Rev. D.** Sections 5.1–5.2 describe transmit shaping, DAC, ADC, equalization, clock recovery, decoding and descrambling. [Manufacturer PDF](https://www.ti.com/lit/ds/symlink/tlk110.pdf)
- **[S2] Linux kernel: Netlink interface for ethtool.** Relevant sections include `CABLE_TEST_TDR` and `MSE_GET`, including MSE capability/window/refresh metadata. [Kernel documentation](https://docs.kernel.org/networking/ethtool-netlink.html)
- **[S3] Analog Devices 78Q2120C product documentation.** Lists register-programmable transmit amplitude, PCS bypass, pulse shaping and obsolete status. [Manufacturer page](https://www.analog.com/en/products/78q2120c.html)
- **[S4] TI DP83867IR/CR datasheet, Rev. J, June 2026.** Register tables 8-148 through 8-151 describe per-channel MSE; see indirect-access requirements and speed restrictions. [Manufacturer PDF](https://www.ti.com/lit/ds/symlink/dp83867ir.pdf)
- **[S5] TI DP83867 Troubleshooting Guide, Rev. D, May 2026.** Includes link-quality diagnostics, loopback/BIST and extended register access. [Manufacturer application note](https://www.ti.com/lit/pdf/snla246)
- **[S6] TI: How to Integrate Linux Driver Into Your System.** Discusses implementation-dependent diagnostics and a TDR requirement for the partner to be silent in its described setup; do not generalize that requirement to every PHY. [Manufacturer application note](https://www.ti.com/lit/an/snla450/snla450.pdf)
- **[S7] Tektronix: Physical Layer Compliance Testing for 1000BASE-T Ethernet.** Describes differential probes, acquisition requirements and Ethernet fixtures. Compliance-test requirements are not automatically the minimum for every exploratory measurement. [Manufacturer application note](https://www.tek.com.cn/documents/application-note/physical-layer-compliance-testing-1000base-t-ethernet)
- **[S8] Tektronix: retrieving and plotting oscilloscope waveform data in Python.** Establishes a programmatic instrument-capture route. [Manufacturer example](https://www.tek.com/en/support/faqs/programing-how-get-and-plot-waveform-dpo-mso-mdo4000-series-scope-python)
- **[S9] Microchip LAN8804 datasheet.** Sections 5.2.4–5.2.6 describe timing recovery, adaptive equalization, simultaneous bidirectional signaling on all pairs, echo/NEXT cancellation and coding. [Manufacturer PDF](https://ww1.microchip.com/downloads/en/DeviceDoc/DS-LAN8804-00003591C.pdf)
- **[S10] Microchip: Ethernet Overview.** Lists physical media/pair counts for common Ethernet families. [Manufacturer overview](https://developerhelp.microchip.com/xwiki/bin/view/applications/ethernet/ethernet-overview/)
- **[S11] Linux kernel: ethtool utility.** Identifies standard discovery/configuration functions and driver dependence. [Kernel project page](https://kernel.org/pub/software/network/ethtool/)

## AI HANDOFF

**Goal:** Preserve what is documented, what is inferred, and what the next CLI must measure.

**Current state:** Generic source-backed findings; exact user hardware and practical channel remain unverified.

**Decisions made:** Do not infer total physical invisibility from missing raw samples; inspect exact-device telemetry and controls; retain separate claims for observation, decoding, coexistence and computation.

**Files changed:** This FYI and the companion CLI experiment handoff.

**Validation performed:** Primary-source findings compiled and separated from hypotheses; no hardware measurements or executed simulations.

**Open questions / risks:** Exact devices, topology, management access, valid live-link controls, sensor bandwidth and automatic compensation.

**Recommended next move:** Give the companion brief to a CLI on the actual hosts; begin with Scope A and B. Use the dispatch cards for later scoped researchers.

**Agent:** Wave
