# https://github.com/viswavi/SciREX
export test_file=scirex_dataset/release_data/test.jsonl
export test_output_folder=../drive/MyDrive/SciREX/test_outputs/ner_only/
export ner_output_folder=../drive/MyDrive/SciREX/test_outputs/ner_only/
export scirex_archive=../drive/MyDrive/SciREX/SI-SciREX/a100_b20_e20/outputs/pwc_outputs/experiment_scirex_full/main/
export cuda_device=0

echo "Predicting NER"
python scirex/predictors/predict_ner.py \
$scirex_archive \
$test_file \
$ner_output_folder/ner_predictions.jsonl \
$cuda_device

echo "Evaluating on NER only"
python scirex/evaluation_scripts/ner_evaluate.py \
--gold-file $test_file \
--ner-file $ner_output_folder/ner_predictions.jsonl
