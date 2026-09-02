# @Epoch Research Report — Technical Distributed Systems Survey
Date: 2026-07-13
Triggered by: Independent deep-pass research request across ten distributed systems topic areas
Scope: Default radar extended with topic-specific literature search; no project contract read

---

## 1. Loop-Redundant Distributed Graph Architectures

The most architecturally significant finding in this area concerns the cost asymmetry between creating and maintaining cycles. In a spanning-tree topology, any single-edge failure produces a partition — the network must reconverge a new spanning tree before traffic can resume, which in Spanning Tree Protocol (STP) implementations requires full topology rebroadcast and can take seconds to tens of seconds. Closing that same edge into a cycle instead of a tree edge eliminates the partition vulnerability but introduces state complexity: every node in the cycle must maintain enough topology state to reason about whether a given path is still valid.

Recent work (Rodrigues et al., December 2025) addresses local repairs upon node/edge failures in distributed spanning trees with O(log n) message complexity per repair, representing a significant improvement over brute-force MST recomputation. However, the fundamental constraint remains: tree-structured overlays support single-edge-failure rerouting only after reconvergence, which requires some form of coordination signal. Mesh topologies support local rerouting (swap routing — replacing a failed link with a single detour arc from the underlying graph) without global reconvergence, at the cost of state that scales with cycle count. The GraphFT framework (WASA 2025) applies a related principle to iterative graph processing workloads: local correction of faulty computation states without global re-execution, achieving up to 14x efficiency improvement over triple modular redundancy. The tradeoff across all these designs is consistent — loop richness buys local recoverability; tree structure buys low overhead; every practical system picks a point on that spectrum.

The quorum-based redundant cycle approach (USPTO/arxiv literature) reports mean fault coverage rates above 96-97% with cycle redundancy, at lower resource cost than fully paired-link redundancy. This confirms the engineering intuition that a few well-placed cycles yield near-mesh resilience with near-tree overhead. The 6G resilience white paper (arXiv 2509.09005, 2025) frames this as a structural principle for next-generation networks: purely centralized designs concentrate risk; purely distributed designs shorten feedback but trade efficiency; the viable space is a mix of fast local control loops at the edge with lightweight central coordination for global decisions.

Key sources:
- [GraphFT: A Lightweight Fault-tolerant Framework for Iterative Graph Processing — WASA 2025](https://link.springer.com/chapter/10.1007/978-981-96-8731-2_18)
- [Enhancing fault tolerance capabilities in quorum-based cycle routing — arXiv](https://arxiv.org/pdf/1608.05172)
- [6G Resilience White Paper — arXiv 2509.09005](https://arxiv.org/pdf/2509.09005)
- [Fault tolerance in distributed graph processing networks — USPTO](https://image-ppubs.uspto.gov/dirsearch-public/print/downloadPdf/10635562)

---

## 2. Multi-Tier Transport and Caching Architectures

The most architecturally significant recent contribution is from the LLM inference domain: the Kareto system (arXiv 2603.08739, 2026) explicitly formalizes tier selection as a multi-objective Pareto optimization problem across cost, throughput, and latency. Kareto offloads KV cache from GPU memory (DRAM tier, nanosecond-to-microsecond latency) to external storage tiers (flash/SSD, millisecond latency) and uses a diminishing-return-guided pruning method to navigate the configuration space. The reported results — up to 9.3% throughput improvement, 58.3% latency reduction, or 20.2% cost reduction depending on which objective is prioritized — quantify concretely what tier selection buys. The critical design insight is that a single tier-selection policy cannot simultaneously optimize all three objectives; the system must expose a Pareto frontier and let the operator pick a point.

In the general distributed systems caching literature (GitNexa, 2026; NeuralStack, 2026), the three-tier pattern is now the baseline for production services: an in-process LRU cache (sub-millisecond, limited to a single instance), a distributed cache layer such as Redis (1-8ms in-region, shared across instances), and a persistent store (10ms to seconds). Tier promotion and demotion are governed by TTL, write-through or write-behind policies, and hot-partition detection. The canonical engineering observation is that a well-placed cache cuts primary store load by 70-95%, but at the cost of staleness windows that must be accepted by the application. The Multilevel Bidirectional Cache Filter (arXiv 2206.13367) introduces bidirectional flow — data can be promoted up toward the faster tier or demoted down toward the persistent tier based on access pattern, rather than moving in only one direction — which addresses the problem of cold data consuming fast-tier capacity.

Tier selection governance converges on two mechanisms: explicit TTL with invalidation signals from writes (for consistency-sensitive data), and access-frequency-based promotion (for read-heavy, tolerance-for-staleness data). The design space between "fast but shallow" and "slow but deep" is navigated by accepting that the same data may legitimately live at different tiers simultaneously with different freshness guarantees. The open problem is automated tier configuration under dynamic workloads — Kareto represents the current state of the art for that problem in the LLM inference context; the general production caching domain still relies mostly on manual TTL tuning and monitoring-driven adjustments.

Key sources:
- [Adaptive Multi-Objective Tiered Storage Configuration for KV Cache in LLM Service — arXiv 2603.08739](https://arxiv.org/html/2603.08739v1)
- [Architecting Multi-Tier Caching on AWS — Medium, May 2026](https://medium.com/@rajeshiyer9944/architecting-multi-tier-caching-on-aws-f096578d9dff)
- [Advanced Caching Strategies Guide for 2026 — GitNexa](https://www.gitnexa.com/blogs/advanced-caching-strategies)
- [Multilevel Bidirectional Cache Filter — arXiv 2206.13367](https://arxiv.org/pdf/2206.13367)

---

## 3. Decentralized Exchange and Redistribution Without Central Controller

The most architecturally significant insight is that gossip protocols — often treated as a pure broadcast mechanism — encode a demand-sensitive redistribution property through their random-peer selection. Each node samples a random neighbor and exchanges state; if a resource is scarce on one side of the exchange, it will be pushed toward the shortage side after enough rounds. This is not price discovery in any formal sense, but it achieves scarcity-responsive redistribution: nodes with excess are statistically more likely to transfer toward nodes with deficit because the probability of a transfer completing is proportional to the differential. OptimumP2P (arXiv 2508.04833, 2025) demonstrates fast and reliable gossiping with formal latency and reliability bounds for large P2P networks, representing the current performance frontier for this class of protocol.

The most recent framing (Habiba and Khan, arXiv 2508.01531, 2025) argues that gossip fills a "missing coordination layer" in large-scale multi-agent systems — specifically the layer between direct point-to-point messaging (reliable but non-scalable) and global broadcast (scalable but non-targeted). The gossip layer enables emergent global awareness from purely local exchanges without any central coordinator. Production systems using this pattern include Apache Cassandra (failure detection and cluster membership via gossip), HashiCorp Consul (health state propagation), and Scuttlebutt (social-graph replication). The fundamental unresolved problem in decentralized exchange is semantic filtering: gossip propagates state indiscriminately, and ensuring that the right content reaches the right node without centralized routing requires either structured overlays (DHT-based approaches like Kademlia) or content-based routing with significant per-node indexing overhead.

The "transfer more toward shortage" rule without central price discovery is partially implemented in epidemic pull protocols, where a node requests a resource only when it detects local deficit, generating a demand signal that propagates upstream. Demand-pull gossip (discussed under topic 8 below) solves a related but distinct problem. The gap in current architectures is that no production system cleanly combines gossip-based scarcity detection with structured transfer; most systems use gossip for state propagation and a separate mechanism (consistent hashing, load balancer, or coordinator node) for actual resource transfer. This remains an open design problem as of mid-2026.

Key sources:
- [OptimumP2P: Fast and Reliable Gossiping in P2P Networks — arXiv 2508.04833](https://arxiv.org/html/2508.04833v1)
- [Revisiting Gossip Protocols: A Vision for Emergent Coordination in Agentic Multi-Agent Systems — arXiv 2508.01531](https://arxiv.org/html/2508.01531v1)
- [A Gossip-Enhanced Communication Substrate for Agentic AI — arXiv 2512.03285](https://arxiv.org/html/2512.03285v1)
- [A Survey of Distributed Data Aggregation Algorithms — arXiv 1110.0725](https://arxiv.org/pdf/1110.0725)

---

## 4. Scale-Free Topology in Distributed Systems

The most architecturally significant finding is a formal asymmetry in the robustness-fragility profile of scale-free networks: they are extremely robust against random node removal but collapse rapidly under targeted hub removal. This has been established analytically and holds over the power-law exponent range 2 < γ < 3. The Barabási-Albert preferential-attachment model produces γ = 3 exactly; most empirically observed networks fall between 2 and 3. The robustness/fragility asymmetry is sharpest in this range. A 2025 arXiv paper on connectivity improvement (arXiv 2509.17652) shows that increasing the power-law exponent — even substantially — yields only limited improvement in targeted-attack resilience, confirming that the asymmetry is a structural property of the degree distribution shape, not a parameter-tuning artifact.

For distributed systems engineering, this asymmetry creates a specific design tension: hub nodes (high-degree nodes in CDN edge caches, service mesh gateway nodes, core DHT nodes) provide significant efficiency gains through concentration of traffic, but their removal — whether through failure, overload, or targeted attack — causes disproportionate damage. Adaptive scale-free topology optimization using deep reinforcement learning (SFTG-DRL, ScienceDirect 2025) represents current state-of-the-art in dynamically managing hub emergence and removal based on load signals in underwater sensor networks; the approach is generalizable but has not been validated at internet scale as of mid-2026. The practical engineering response in production systems is usually a combination of hub redundancy (multiple gateway replicas) with consistent hashing to distribute load across virtual nodes, trading the pure scale-free efficiency for resilience against targeted removal.

The formal bound on the exponent range is: for γ ≤ 2, the network has infinite average degree and the robustness advantage disappears; for γ > 3, degree variance drops and the network approaches Poisson-like random graph behavior, losing both the hub-efficiency and the targeted-attack vulnerability. The range 2 < γ < 3 is where both the efficiency gains and the fragility risk coexist. No production distributed system deliberately operates in this range by design; scale-free degree distributions in production systems (e.g., web link graphs, social network follower distributions) emerge from growth dynamics rather than intentional topology construction.

Key sources:
- [Limited Improvement of Connectivity in Scale-Free Networks by Increasing the Power-Law Exponent — arXiv 2509.17652](https://arxiv.org/html/2509.17652)
- [Adaptive scale-free topology optimization using deep reinforcement learning in UASNs — ScienceDirect 2025](https://www.sciencedirect.com/science/article/abs/pii/S1570870525003695)
- [True scale-free networks hidden by finite size effects — PNAS 2021](https://www.pnas.org/doi/10.1073/pnas.2013825118)
- [Scale-Free Networks: A Decade and Beyond — Barabási, Science 2009](https://barabasi.com/media/pub_imports/files/303.pdf)

---

## 5. Separate Coordination Channels from Data Transport

The most architecturally significant documented tradeoff in control/data plane separation is the failure-boundary isolation benefit versus the synchronization overhead cost. When the control plane and data plane share the same channel, a control-plane failure can bring down data transport; separation creates a fault boundary where "an issue in the control plane does not bring down inspection capabilities in the data plane, and inspection continues uninterrupted during security updates or control-plane incident recovery" (Imperva, 2025). The SDN model makes this explicit: the logically centralized controller communicates with data-plane forwarding elements over a separate southbound API (OpenFlow or equivalent), while actual packet forwarding happens at line rate on the data plane.

The practical cost of separation is state synchronization. Control planes must propagate routing and policy decisions to data planes efficiently; if the synchronization lag is large, data planes act on stale routing state. This is the core tradeoff that led to the term "logically centralized control despite distributed implementation" — pure centralized control introduces a single point of failure and a control-loop bottleneck; the solution is distributing the control plane itself (as in etcd-backed Kubernetes or multi-region Raft clusters) while maintaining logical separation from the data path. The sidecar proxy pattern (Envoy, Linkerd) instantiates this in service mesh architectures: the sidecar handles data-plane traffic interception, mTLS, retries, and observability at the pod level, while the control plane (Istio Pilot, Linkerd control plane) distributes configuration changes to all sidecars separately from the data flow.

Fast Raft (arXiv 2506.17793, 2025) and related consensus research reveals that the consensus protocol itself — the coordination channel — can be a performance bottleneck. Fast Raft reduces commit path from three rounds to two by allowing direct broadcast to a designated quorum on the fast path, falling back to standard Raft only on conflict or message loss. The DRaft double-layer structure (ScienceDirect, 2025) separates local consensus from global ordering, yielding up to 5x throughput improvements under geo-distributed deployments. Both papers confirm that the separation between the coordination signal (consensus) and the data being replicated is architecturally load-bearing — optimizing one without the other leaves significant performance on the table.

Key sources:
- [Fast Raft: Optimizations to the Raft Consensus Protocol — arXiv 2506.17793](https://arxiv.org/html/2506.17793v1)
- [DRaft: A double-layer structure for Raft consensus mechanism — ScienceDirect 2025](https://www.sciencedirect.com/science/article/abs/pii/S1084804525000086)
- [Why Separating Control and Data Planes Matters in Application Security — Imperva](https://www.imperva.com/blog/why-separating-control-and-data-planes-matters-in-application-security/)
- [Crossword: Adaptive Consensus for Dynamic Data-Heavy Workloads — arXiv 2509.07157](https://arxiv.org/pdf/2509.07157)

---

## 6. Hysteretic and Trajectory-Dependent State Machines in Distributed Systems

The most architecturally significant finding is that the circuit breaker pattern — the canonical distributed-systems hysteretic state machine — achieves its stability properties precisely because the thresholds for opening the circuit and closing it are different. A symmetric threshold (open and close at the same error rate) creates chattering: the system oscillates rapidly between states when the error rate hovers near the threshold. The asymmetry provides a deadband: the circuit only reopens after error rate drops well below the opening threshold, preventing rapid oscillation and giving the downstream service time to recover without being bombarded with retry traffic.

Adaptive circuit breakers (USPTO patent 12353270; IJRAI 2025) extend this by making both thresholds dynamic rather than fixed. The opening threshold is computed from historical reliability of the interaction during a past time window; the closing (half-open to closed) threshold uses a separate adaptive value that can be lower than the opening threshold, explicitly encoding the hysteretic structure. The state machine is: Closed → Open when error rate exceeds threshold-open; Open → Half-Open after timeout; Half-Open → Closed when error rate drops below threshold-close (where threshold-close < threshold-open); Half-Open → Open if error rate exceeds threshold-open again. This three-state machine with two distinct thresholds is the canonical implementation of hysteresis in distributed fault tolerance.

TCP's AIMD algorithm encodes the same structural principle at the transport layer. The additive-increase phase (grow congestion window by 1 MSS per RTT) and the multiplicative-decrease phase (halve window on congestion signal) are not symmetric — the ramp-up is slow and linear; the ramp-down is fast and multiplicative. This asymmetry is provably necessary for convergence to fairness and efficiency (Chiu and Jain, 1989). The trajectory-sensitive property — the system responds differently depending on the direction of change — is what enables AIMD to distinguish between "building toward congestion" and "recovering from congestion" without a central coordinator. Backpressure in reactive streams applies the same principle: the request(n) credit mechanism means consumers ramp up demand incrementally but can instantly stop the flow by withholding credits, creating an asymmetric ramp-up/ramp-down at the application layer.

Key sources:
- [Circuit Breaker Pattern in Modern Distributed Systems — IJRAI 2025](https://ijrai.org/index.php/ijrai/article/download/433/402)
- [System and method for adaptively managing services using circuit breaker — USPTO 12353270](https://image-ppubs.uspto.gov/dirsearch-public/print/downloadPdf/12353270)
- [Additive increase/multiplicative decrease — Wikipedia (canonical reference)](https://en.wikipedia.org/wiki/Additive_increase/multiplicative_decrease)
- [Circuit Breaker Patterns with Adaptive Thresholds — Raghu's Notes](https://raghu-vijaykumar.github.io/docs/docs/system-design/examples/technical-concepts/circuit-breaker-patterns-with-adaptive-thresholds/)

---

## 7. Long-Horizon Identity Preservation in Distributed Systems

The most architecturally significant design principle here is that durable logical identity in a distributed system must be a property of the data structure and addressing scheme, not of specific physical nodes. Consistent hashing encodes this directly: a key's ownership is determined by its position on the hash ring relative to the nearest node in the ring direction. When a node joins or leaves, only the keys adjacent to that node's ring position are remapped — O(1/N) of the total key space. The logical identity of each key (its mapping to an owner) is preserved across arbitrarily many node replacements; no key ever needs to be updated when the node holding it is replaced, as long as the ring topology is maintained.

Virtual nodes (vnodes) extend this by distributing each physical node across multiple ring positions, which reduces load variance and makes the per-failure remapping granular enough to be handled without hot spots (Frontiers in Computer Science, 2025). The Distributed Learned Hash Table (arXiv 2508.14239, 2025) explores replacing the hash ring with a learned mapping function that can optimize key distribution based on observed access patterns, representing a potential successor to static consistent hashing. CRDTs (Conflict-free Replicated Data Types) address a related but distinct identity problem: state identity across concurrent modifications. A CRDT's invariant is that all replicas converge to the same state regardless of the order in which operations are applied — identity is preserved not through coordination but through the algebraic properties of the data type (monotone join-semilattice structure for state-based CRDTs; commutative and idempotent operations for operation-based CRDTs).

Log-structured storage with compaction (LSM-tree based systems: LevelDB, RocksDB, Apache Cassandra) solves identity preservation at the storage layer: writes are always appends to an immutable log; compaction merges log segments while preserving the latest value for each key. The logical record (keyed identity) survives indefinitely even as the physical storage files are repeatedly replaced. AutoComp (arXiv 2504.04186, SIGMOD 2025) addresses the open problem of automating compaction scheduling in data lakes (Delta Lake, Iceberg, Hudi), where the same append-only principle creates small-file proliferation. In all three mechanisms — consistent hashing, CRDTs, LSM-trees — the pattern is identical: logical identity is encoded in the addressing and merge semantics of the structure itself, not in the reliability of any particular component.

Key sources:
- [Distributed caching system with strong consistency model — Frontiers in Computer Science, 2025](https://www.frontiersin.org/journals/computer-science/articles/10.3389/fcomp.2025.1511161/full)
- [A Distributed Learned Hash Table — arXiv 2508.14239](https://arxiv.org/html/2508.14239v1)
- [AutoComp: Automated Data Compaction for Log-Structured Tables in Data Lakes — arXiv 2504.04186 / SIGMOD 2025](https://arxiv.org/html/2504.04186v1)
- [CRDTs: Achieving Eventual Consistency in Distributed Systems — DEV Community](https://dev.to/foxgem/crdts-achieving-eventual-consistency-in-distributed-systems-296g)

---

## 8. Demand-Pull vs. Supply-Push Architectures

The most architecturally significant finding is the formal proof of AIMD's convergence properties: multiple competing flows using additive-increase/multiplicative-decrease all converge to equal usage of a shared link, and the convergence is provably fair and efficient (Chiu and Jain, 1989). This is the canonical result for demand-pull flow control — the consumer signals capacity (via the receive window / congestion window), and the producer adjusts output accordingly. Without the demand-pull signal, a supply-push system has no mechanism for detecting downstream capacity and will either starve or overwhelm its consumers.

Reactive Streams (the specification underlying Project Reactor, RxJava, Akka Streams, Spring WebFlux) formalizes this at the application layer through the request(n) protocol: a subscriber explicitly signals how many items it is prepared to receive; the publisher sends at most n items before waiting for another signal. This is structurally identical to TCP's receive window in intent, but applied at the application stream layer. The demand-pull model's key throughput advantage over pure supply-push is that it eliminates head-of-line blocking caused by slow consumers: a slow consumer withholds credits; the fast producer stops rather than buffering unboundedly. The cost is added round-trip latency for every request(n) signal, which is negligible under sustained high-throughput but adds latency at stream startup and after pauses.

The hybrid credit-based model (HTTP/2 stream windows, gRPC flow control) combines supply-push performance with demand-pull safety: producers push data as long as they have window credits; consumers replenish credits by signaling processed capacity. This outperforms pure pull under high-throughput steady-state (fewer round trips per message) while preserving backpressure protection. Event-driven architectures (Apache Kafka) approximate demand-pull through consumer group offset management: each consumer group pulls from its own offset, consuming at its own rate, with the broker acting as an elastic buffer between producer and consumer timescales. Comparative analysis from 2025 (Growin, 2025; Algoroq, 2025) confirms that demand-pull with buffering outperforms supply-push for workloads where consumer processing rate is variable and unpredictable, while supply-push with credit windows is preferred for low-latency, predictable-throughput pipelines.

Key sources:
- [Backpressure Patterns in Distributed Systems — Algoroq, 2025](https://www.algoroq.io/blog/backpressure-distributed-systems/)
- [Detailed Backpressure: Designing Stable, Flow-Controlled Systems — martinuke0's Blog, December 2025](https://martinuke0.github.io/posts/2025-12-12-detailed-backpressure-designing-stable-flow-controlled-systems/)
- [Reactive Programming Paradigms in High-Throughput Systems — EAJOURNALS 2025](https://eajournals.org/bjms/wp-content/uploads/sites/21/2025/05/Reactive-Programming.pdf)
- [Event Driven Architecture Done Right: How to Scale Systems with Quality in 2025 — Growin](https://www.growin.com/blog/event-driven-architecture-scale-systems-2025/)

---

## 9. Tiered Dependency: Hard-Coupled and Soft-Coupled Subsystem Design

The most architecturally significant formal treatment of this problem is the AWS Well-Architected Framework's explicit definition of the hard/soft dependency boundary (REL05-BP01, updated February 2025): a hard dependency is one where the depending component cannot perform its core function if the dependency is unavailable; a soft dependency is one where the component can continue operating in degraded mode, serving stale data, alternate data, or reduced functionality. The architectural guidance is that hard dependencies should be minimized through static fallbacks, cached responses, and default behaviors — effectively converting hard dependencies into soft dependencies wherever possible.

The Scalable Graceful Degradation framework (Shelton/Koopman, ACM; referenced in 2025 literature) addresses this at the formal level: by partitioning a system into subsystems where each subsystem contributes independently to overall utility, the state space complexity of failure analysis drops from O(2^N) — where N is the total component count — to O(N × 2^k) where k is the maximum size of any subsystem. This is the key formal result: subsystem decomposition makes graceful degradation analysis tractable. A subsystem that operates independently when its dependencies are gone is a soft dependency; one that fails entirely is a hard dependency. The partitioning algorithm is equivalent to identifying strongly connected components in the dependency graph that have no out-edges to other critical components.

The circuit breaker pattern (topics 6 and 5) is the runtime mechanism that enforces the soft/hard boundary: when a soft dependency's circuit opens, the depending component falls back to its degraded behavior; when a hard dependency's circuit would open, the depending component must fail along with it. The 6G resilience white paper (arXiv 2509.09005) frames this as "islanded operations" — edge nodes that continue operating on locally cached state when backhaul to the core is lost, which is the communications-network instantiation of soft dependency design. The open problem as of mid-2026 is the absence of a general formal coupling classification framework that spans multiple architectural layers (storage, network, compute, application logic) — the AWS guidance and Shelton/Koopman framework address this within a layer; cross-layer coupling classification remains an open research area.

Key sources:
- [REL05-BP01 Implement graceful degradation to transform applicable hard dependencies into soft dependencies — AWS Well-Architected Framework, 2025](https://docs.aws.amazon.com/wellarchitected/latest/reliability-pillar/rel_mitigate_interaction_failure_graceful_degradation.html)
- [Scalable graceful degradation for distributed embedded systems — Shelton/Koopman, ACM](https://dl.acm.org/doi/abs/10.5555/979016)
- [Design interactions in a distributed system to mitigate or withstand failures — AWS Reliability Pillar](https://docs.aws.amazon.com/wellarchitected/latest/reliability-pillar/design-interactions-in-a-distributed-system-to-mitigate-or-withstand-failures.html)
- [6G Resilience White Paper — arXiv 2509.09005](https://arxiv.org/pdf/2509.09005)

---

## 10. RAG Architecture: Current State and Open Problems

The most architecturally significant empirical finding in current RAG literature is the retrieval-dominance of failure: industry analysis (2026) consistently shows that when RAG systems fail, 73% of failures originate in the retrieval stage rather than the generation stage. This is corroborated by the ACL 2026 systematic taxonomy (Garani, 2026), which identifies 33 failure modes across 7 pipeline stages (ingestion, representation, retrieval, generation, evaluation, deployment, agentic orchestration) and finds that retrieval and generation failures are comparatively well-studied while representation, evaluation, and all 8 agentic orchestration failure modes lack peer-reviewed empirical evidence.

The semantic entanglement problem (arXiv 2604.17677, 2026) formalizes a structural root cause of retrieval failure: when source documents conflate multiple topics within contiguous text, standard vectorization produces embedding spaces where semantically distinct content occupies overlapping geometric neighborhoods. The paper defines an Entanglement Index (EI) as a quantitative measure of this cross-topic overlap and argues that higher EI directly reduces attainable Top-K retrieval precision under cosine similarity. The proposed four-stage Semantic Disentanglement Pipeline (SDP) addresses this at ingestion time rather than at retrieval time — the correct architectural lever, since retrieval quality is bounded by representation quality. This reframes chunking strategy (the most common point of failure cited in practitioner literature) as a special case of a more general representation problem.

Microsoft's GraphRAG (open-sourced July 2024, LazyGraphRAG variant released June 2025) represents the current state-of-the-art for multi-hop reasoning in RAG: entity extraction via GPT-4, relationship mapping through co-occurrence analysis, community detection via the Leiden algorithm, and retrieval at the level of graph communities rather than flat document chunks. LazyGraphRAG reduces indexing cost to 0.1% of full GraphRAG while preserving most of the multi-hop reasoning capability. The hybrid retrieval architecture (dense embedding-based retrieval + sparse BM25 + graph-structured retrieval + cross-encoder reranking) is now the industry consensus for production RAG, offering the best quality-to-cost ratio for most use cases. The documented failure modes of naive RAG (40% retrieval failure rate, context fragmentation from fixed-window chunking, staleness from infrequent index refresh) are all structurally addressable; the documented open problems are: agentic orchestration failures (all 8 modes lack empirical study), evaluation failures (no ground truth for open-domain multi-hop), and representation failures in multilingual and multi-modal documents.

Key sources:
- [A Systematic Taxonomy of Failure Modes in Retrieval-Augmented Generation Systems — ACL 2026](https://aclanthology.org/2026.trustnlp-main.27/)
- [Semantic Entanglement in Vector-Based Retrieval — arXiv 2604.17677](https://arxiv.org/pdf/2604.17677)
- [Microsoft GraphRAG Architecture and Lessons Learned — Ideasthesia](https://www.ideasthesia.org/microsoft-graphrag-architecture-and-lessons-learned/)
- [RAG Is Not Dead: Advanced Retrieval Patterns That Actually Work in 2026 — DEV Community](https://dev.to/young_gao/rag-is-not-dead-advanced-retrieval-patterns-that-actually-work-in-2026-2gbo)
- [RAGTrace: Understanding and Refining Retrieval-Generation Dynamics — arXiv 2508.06056](https://arxiv.org/pdf/2508.06056)

---

## Cross-Cutting Patterns

Several structural principles recur across multiple topic areas, suggesting they are not domain-specific but general properties of distributed system design.

**Asymmetric response to direction of change.** This pattern appears in at least four topic areas independently. TCP AIMD uses linear growth and multiplicative decrease (topic 8). Circuit breakers use separate thresholds for opening and closing (topic 6). Scale-free networks are highly resilient to random failure but fragile to targeted removal — asymmetric response to failure type (topic 4). Cache TTL with write invalidation is fast to evict but slow to repopulate (topic 2). The functional benefit in all cases is the same: the system can ramp up cautiously and ramp down aggressively when stressed, which prevents overshoot in both directions. This is the defining property of hysteresis applied as a control strategy.

**Structural identity vs. component identity.** This principle appears in consistent hashing (topic 7), LSM-tree compaction (topic 7), CRDTs (topic 7), loop-redundant graph rerouting (topic 1), and RAG retrieval indexes (topic 10). In each case, the logical entity that persists is defined by the structure or addressing scheme, not by any specific physical node or file. When a physical component is replaced, the structural identity survives. This is the distributed-systems answer to component turnover: make identity a property of the addressing space, not a property of the hardware.

**Separation of fast signal from slow data.** Topics 5, 2, and 8 all instantiate this principle in different forms. SDN separates the routing control signal from packet forwarding. Multi-tier caches separate fast-path reads (DRAM) from slow-path persistence (disk). Demand-pull flow control separates the credit/demand signal (low bandwidth, control-critical) from the data stream (high bandwidth, delay-tolerant). In all cases, the performance gain comes from matching the latency and bandwidth characteristics of the channel to the latency sensitivity and bandwidth requirement of the information being carried.

**Local recoverability at the cost of state.** Topics 1, 3, 6, and 9 all trade higher per-node state for the ability to recover from failures locally without waiting for global coordination. Loop-redundant topologies maintain cycle state so that rerouting requires no coordination. Circuit breakers maintain per-dependency state so that failure isolation requires no coordination. Gossip protocols maintain partial global state at every node so that state propagation requires no coordinator. Soft dependencies maintain a fallback behavior in local state so that dependency failure requires no escalation. The unified principle: local recoverability is always paid for with local state.

**Representation quality as upstream bound on downstream performance.** This is most explicit in topic 10 (RAG: retrieval quality is bounded by representation quality, which is determined at ingestion time), but appears structurally in topic 7 (identity preservation requires correct addressing at data-entry time, not at retrieval time), topic 2 (cache efficiency is bounded by the cache key and TTL design, determined at cache-write time), and topic 3 (gossip propagation quality is bounded by the state schema each node maintains). The general principle: downstream processing stages cannot recover information that was lost or degraded by upstream representation choices. Fix it at ingestion or accept the ceiling.

---

Sections to refresh: [RAG agentic orchestration failure modes — no peer-reviewed evidence as of 2026-07-13; GraphRAG evaluation benchmarks; adaptive scale-free topology at internet scale; formal cross-layer coupling classification; distributed learned hash tables in production; LazyGraphRAG production deployments]

CONFIDENCE SUMMARY:
- Topics 1, 5, 6, 8: H — official papers + production system documentation
- Topics 2, 7, 9, 10: H — peer-reviewed papers (SIGMOD, ACL) + official framework docs
- Topics 3, 4: M — strong arxiv preprints + established literature, some claims extrapolated from first principles
