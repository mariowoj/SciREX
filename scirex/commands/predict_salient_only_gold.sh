# https://github.com/viswavi/SciREX
export test_file=scirex_dataset/release_data/test.jsonl
export test_output_folder=../drive/MyDrive/SciREX/test_outputs/salient_only/
export scirex_archive=../drive/MyDrive/SciREX/SI-SciREX/a100_b20_e20/outputs/pwc_outputs/experiment_scirex_full/main/


echo "Predicting Salient Mentions"
python scirex/predictors/predict_salient_mentions.py \
$scirex_archive \
scirex_dataset/release_data/test.jsonl \
$test_output_folder/salient_mentions_predictions.jsonl \
$cuda_device

echo "Predicting Salient Clustering "
python scirex/predictors/predict_salient_clusters.py \
$test_file \
$test_output_folder/salient_mentions_predictions.jsonl \
$test_output_folder/salient_clusters_predictions.jsonl

echo "Evaluating on all gold steps "
python scirex/evaluation_scripts/salient_only_evaluate.py \
--gold-file $test_file \
--ner-file $test_file \
--clusters-file $test_output_folder/salient_clusters_predictions.jsonl \
--salient-mentions-file $test_output_folder/salient_mentions_predictions.jsonl
