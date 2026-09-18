# Anthropic News - 2026-09-18

> 対象期間: 2026-09-17 〜 2026-09-18（2日分）／取得元: https://www.anthropic.com/news

## 今回の対象エントリ

### Measurements for understanding the pace of AI development inside frontier labs
- **Date**: Sep 17, 2026
- **Category**: （インデックス上ではカテゴリ表記なし／Anthropic Institute 掲載）
- **URL**: https://www.anthropic.com/institute/measuring-pace-of-ai-development
- **Summary**: Anthropicは、フロンティアラボ内部のAI開発のペースへの外部からの可視性を高めるため、3つのプロトタイプ測定を公開した。1つ目の「Anthropic R&D Automation Index」は社内のAI R&DタスクをEpoch AIのAutomation Level尺度（AL0〜AL5）で評価するもので、2026年8月時点でClaudeがAnthropicのAI R&D業務の26%を「リード」レベル（AL4）で担い、90%超の業務が「AI協働」（AL3）以上、完全自律（AL5）は該当なしという。2つ目のAIエージェント監視では、最も利用される内部プラットフォーム上に常時約30,000の研究・エンジニアリング向けエージェントが稼働し、オンラインモニターが実行前アクションの100%をカバー、2026年8月に分析された10億件超の決定のうち0.002%（約47,000件に1件）がブロックされた。3つ目の計算資源配分では、2026年7月13〜20日の1週間スナップショットで、AI R&D向け計算資源の約6%、AI駆動のAI R&D向けの約12%が安全性業務に充てられている。第三者評価者の受け入れと、他のフロンティア開発者が複製できる共通方法論を提案しており、Dario Amodeiの「We must pace the frontier」論文を踏まえたフロンティアペーシング議論への材料とする。
- **開発者への影響**: フロンティアラボの自動化率・監視・安全性への計算資源配分が具体的な数値で公開される最初期の事例であり、将来のペーシング規制や第三者検証の枠組みがClaudeモデルのリリース運用に反映される可能性を示す。

### Introducing the Life Sciences Verification Program
- **Date**: Sep 17, 2026
- **Category**: Announcements
- **URL**: https://www.anthropic.com/news/life-sciences-verification-program
- **Summary**: ライフサイエンス専門家を対象とするベータプログラム「Life Sciences Verification Program（LSVP）」を開始した。Mythos・Opus・Sonnetモデルに対し、生物学関連作業でより寛容なセーフガード付きアクセスを提供し、一般提供中のFableモデルではブロックされる創薬・研究生物学・臨床開発・製造などのタスクを可能にする。申請時には研究資格・セキュリティ基準・倫理的監督体制が審査され、「Standard Useグラント」（Mythos 5.1・Opus 5・Sonnet 5対象、チーム単位・年次更新）と、アドオンの「High-risk Useグラント」（Opus 5とSonnet 5対象、生物学リクエストをブロックするセーフガードをすべて解除、単一研究プロジェクト単位・6ヶ月ごと更新）の2種類がある。セキュリティは「共有責任」モデルで、リアルタイムブロックからオフラインモニタリング（フラグ対象アクティビティの30日間データ保持、訓練には不使用）に移行し、サイバー分類器など他のセーフガードは維持される。提供面はファーストパーティAPIコンソール・Claude for Enterprise・Teamプランで、応募は claude.com/form/life-sciences-verification-program から受け付ける。
- **開発者への影響**: バイオ分野のアプリやエージェントを扱う開発者は、検証済み組織としてAPI・Claude for Enterprise・TeamプランでFableでは拒否される生物学タスクを実行できる。ただしBAA有効な組織・個人プラン・サードパーティプラットフォームは現時点で対象外。

## Source References
- Anthropic News: https://www.anthropic.com/news
