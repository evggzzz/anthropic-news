# Anthropic News - 2026-09-11

> 対象期間: 2026-09-10 〜 2026-09-11（2日分）／取得元: https://www.anthropic.com/news

## 今回の対象エントリ

### Detecting and countering misuse of AI: September 2026
- **Date**: 2026-09-10
- **Category**: Announcements
- **URL**: https://www.anthropic.com/threat-intelligence-report-september-2026
- **Summary**: 脅威インテリジェンスレポートの2026年9月版（過去版は2025年3月・8月・11月）で、2025年12月〜2026年8月に検知・妨害した活動をサイバー作戦・影響作戦・監視・詐欺・生物学的悪用・通常兵器開発・不正ディスティレーションの7分野に分けて、追跡ID（GTG-xxxxx）付きの事例として公開している。悪用されたのはClaude Haiku・Sonnet・Opusで、Claude FableおよびMythosクラスのモデルは不正ディスティレーション1件を除き関与していない。サイバー事例では、Microsoftの報告と整合するロシアの諜報活動（GTG-20006、ウクライナ・欧州の政府機関やドローン供給網など20以上の組織を標的）、ShinyHunters系（GTG-50014、AWS EC2 10台で180万APKをスキャンし1TB超を窃取）、中国・長沙のオペレーター（GTG-10007、1か月で十数件のゼロデイ候補を生む自律的エクスプロイト生成）、約4日で約30社のAI企業を攻撃して事前公開のClaudeモデルへのアクセスを試みたロシア語圏の犯罪者（GTG-50020、アクセスは未達でAnthropicのシステムは侵害されず）などを詳細に記述している。影響作戦では6大陸・9件（選挙に合わせたものを含む）を紹介し、中央アフリカ共和国のラジオ局Radio Lengo Songoを用いるロシアFIMI（GTG-04001、Breakout Scale Category 4）、フランスLKM Companyによる約70の偽ニュースサイトと約20言語8,913本の記事（GTG-54002）、マレーシアの選挙操作プラットフォームを販売するイスタンブールのBBS Bilisim（GTG-84005）などを挙げる。Anthropicは関連アカウント・組織の停止、自動的な振る舞い検知の構築、当局・業界・被害者への情報共有に加え、無力化済みドメイン・egress IP・Telegram ID・ファイルハッシュ等のIOC（侵害の痕跡）を公開しており、攻撃の変化は手法でなく「経済性」（自律化が速度と規模を増幅させる）にあると論じている。
- **開発者への影響**: 公開されたIOC一覧は自組織のログ検知にそのまま利用できる。また正規外の「Claude APIリセラー」が認証情報を収集する事例（GTG-50021）が明示されたため、APIキーの調達・経由経路を公式チャネルに限定する確認の機会になる。

## Source References
- Anthropic News: https://www.anthropic.com/news
