# Anthropic Research - 2026-09-08

> 対象期間: 2026-09-02 〜 2026-09-08（7日分）／取得元: https://www.anthropic.com/research

## 今回の対象ポスト

### Formalizing Fermat's Last Theorem
- **Date**: Sep 4, 2026
- **Category**: Science
- **URL**: https://www.anthropic.com/research/formalizing-fermats-last-theorem
- **Summary**: Anthropicは、フェルマーの最終定理（FLT）の証明をLean証明支援系でend-to-endに機械検証した初の成果として公開した。Claudeが主体として約11日間で約1,300万行のLeanコードを生成し、最終証明で用いる29,500個の中間定理を含む計30,300個の検証可能な証明を完成させた。証明の規模はベースとなったコミュニティ数学ライブラリMathlibの5倍以上で、依存する公理はLeanの標準3公理のみであり、比較ツールでMathlibのFLTステートメントとの一致も確認済み。手法としてはWilesの証明のDarmon–Diamond–Taylorによる簡略版に沿い、Claude Codeベースのマルチエージェント基盤上で数十のエージェントが、コロンビア大学のTianyi Pengらが設計したオープンPlatform「Prove2Me」を通じて協調した。Prove2Meは定理ステートメントのDAG管理、ステートメントと証明の分離によるLeanコンパイル高速化、定理の検索・再利用を実現し、人間の関与はPengによる散発的な高レベル指示に留まった。限界として、初期のマルチエージェント試行はプロジェクト状態を喪失して協調に失敗した（失敗分も非ボイラープレート行の約7%を占める）、証明は必要以上に長い、検証負担が消えるのではなく移動するだけである点が明記されている。査読したImperial College LondonのKevin Buzzardは「数学の公理以外の仮定なしにFLTを証明する驚くべきautoformalization達成」と評価した。
- **論文リンク**: https://doi.org/10.48550/arXiv.2608.28433 （Prove2Me論文）／証明コード: https://github.com/anthropics/fermats-last-theorem

## Source References
- Anthropic Research: https://www.anthropic.com/research
