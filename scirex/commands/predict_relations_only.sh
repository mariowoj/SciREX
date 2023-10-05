# https://github.com/viswavi/SciREX
export test_file=scirex_dataset/release_data/test.jsonl
export test_output_folder=../drive/MyDrive/SciREX/test_outputs/relations_only/
export relations_only_archive=../drive/MyDrive/SciREX/SI-SciREX/a100_b20_e20/outputs/pwc_outputs/experiment_scirex_full/main/
export cuda_device=0

echo "Predicting Relations on gold clusters"
echo "relations_only_archive: ${relations_only_archive}"
echo "test_file: ${test_file}"
echo "test_output_folder: ${test_output_folder}"
echo "cuda_device: ${cuda_device}"
python scirex/predictors/predict_n_ary_relations.py \
$relations_only_archive \
$test_file \
$test_file \
$test_output_folder/relations_predictions_gold_clusters.jsonl \
$cuda_device

echo "Evaluating on all Predicted steps "
python scirex/evaluation_scripts/relations_only_evaluate.py \
--gold-file $test_file \
--ner-file $test_file \
--clusters-file $test_file \
--relations-file $test_output_folder/relations_predictions_gold_clusters.jsonl
