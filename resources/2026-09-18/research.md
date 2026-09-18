# Anthropic Research - 2026-09-18

> 対象期間: 2026-09-17 〜 2026-09-18（2日分）／取得元: https://www.anthropic.com/research

## 今回の対象ポスト

### How Claude is uplifting biomolecular modeling
- **Date**: 2026-09-17
- **Category**: Science
- **URL**: https://www.anthropic.com/research/claude-uplifts-biomolecular-modeling
- **Summary**: Claudeが、構造予測・タンパク質設計・タンパク質言語モデル・ゲノミクス向けのオープンソース深層学習モデル30以上を、推論最適化やカーネル開発の経験を持たないバイオ分子モデリング経験者2名の監督のもと4週間弱で高速化し、平均約4倍（出力完全一致でも約2倍、構造予測モデルでは約1.6倍）の速度向上を最小限の精度低下で達成した。主要な計算ボトルネックであるtriangle attention / triangle multiplication向けに独自GPUカーネル「FlashPairformer」を開発し、従来の標準をtriangle attentionで2.7〜2.9倍、triangle multiplicationで1.7〜3.2倍上回る新しいstate-of-the-artを達成した。低メモリの「Big」モードにより、単一NVIDIA GPUノードで10,000トークン超の分子機械（ヒトミトコンドリア複合体I、TRiCシャペロン複合体、プロテアソーム、細菌リボソーム）を正確に予測し、31,000〜70,000トークン超のウイルスカプシド等でも推論自体は成功した。タンパク質設計では、3種のClaudeモデル（Mythos 5.1、Mythos 5、Opus 5）がサブエージェントなしでH200 1台・24時間・約1,100語のプロンプトという条件で16ターゲットに取り組み、ipSAEスコア（in silico結合スコア）が約100倍のGPU時間を使った以前のキャンペーン（1ターゲット最大$10,000）と同等になり、GPUとトークンの合計支出は約$150に抑えられた。限界として、訓練コンテキストの約2桁上のシステムの構造は正しく予測できず一般化の限界が示される一方、最適化コードは全モデル分をGitHubで公開し、Adaptyv Bioとのタンパク質設計コンペ（Claudeクレジット最大$100万・Modal計算クレジット$25万・5,000以上のデザインのウェットラバリデーション）とLife Sciences Verification Programの公開ベータ開始も発表された。
- **論文リンク**: https://www-cdn.anthropic.com/c03643714397d9d396fa1ce1794f5f9f7863a82c.pdf （技術報告書PDF）／コード: https://github.com/anthropics/uplifting-biomolecular-modeling

## Source References
- Anthropic Research: https://www.anthropic.com/research
