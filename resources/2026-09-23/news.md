# Anthropic News - 2026-09-23

> 対象期間: 2026-09-22 〜 2026-09-23（2日分）／取得元: https://www.anthropic.com/news

## 今回の対象エントリ

### Introducing Claude Opus 5.5
- **Date**: 2026-09-22
- **Category**: Announcements
- **URL**: https://www.anthropic.com/claude-opus-5-5
- **Summary**: Anthropicが新ファミリー「Claude 5.5」の最初のモデルとしてClaude Opus 5.5を公開した。APIモデルIDは`claude-opus-5-5`で、Sonnet 5.5とHaiku 5.5が数週間中に続く。価格は100万トークンあたり入力$4／出力$20とOpus 5比20%安、キャッシュ読み取りは$0.20で60%低減されており、通常のワークロードではOpus 5比でおよそ40%のコスト低下と30%超の出力高速化を主張する。最大2.5倍速のFastモードは入力$8／出力$40。Terminal-Bench 4.0では66.4%（xhigh effort）を記録し、Fable 5.1の55.8%やGPT-6 Astraの57.9%を上回るほか、FrontierCode v1.1では54.4%となっている。
- **Summary(続き)**: 提供はAWS・Google Cloud・Microsoft Azure・Claude Platformの全プラットフォームで、Pro／Max／Team／シート制Enterpriseプランでは5時間あたりの利用上限が引き上げられ、レート制限のリセットを保存できるようになった。自動行動監査（約2,000シナリオ）では、包囲回避（containment circumvention）の試みがOpus 5やClaude Mythos 5.1比で約85%少ないという結果が報告されている。セーフガードはFable 5.1と同等の水準（サイバー、バイオ、蒸留耐性）で、ゼロデータリテンション・EU AI Act対応のウォーターマーク・thinkingモード無効化オプションなしで提供される。
- **開発者への影響**: APIで`claude-opus-5-5`を指定するだけでOpus 5から移行でき、コーディング・エージェントworkloadのコストは約40%、出力速度は30%以上改善する。主要クラウド各社で即日利用可能なため、既存のプロビジョニングやレート制限設定を見直すだけで効果を享受できる。

## Source References
- Anthropic News: https://www.anthropic.com/news
