SET search_path TO mimiciv_derived, mimiciv_hosp, mimiciv_icu, mimiciv_ed;
DROP TABLE IF EXISTS reserch_icu_dataset; CREATE TABLE reserch_icu_dataset AS
 WITH lab as (
    select 
        subject_id,
        stay_id,
        hematocrit_min,
        hematocrit_max,
        hemoglobin_min,
        hemoglobin_max,
        platelets_min,
        platelets_max,
        wbc_min,
        wbc_max,
        albumin_min,
        albumin_max,
        globulin_min,
        globulin_max,
        total_protein_min,
        total_protein_max,
        aniongap_min,
        aniongap_max,
        bicarbonate_min,
        bicarbonate_max,
        bun_min,
        calcium_min,
        calcium_max,
        chloride_min,
        chloride_max,
        creatinine_min,
        creatinine_max,
        glucose_min,
        glucose_max,
        sodium_min,
        sodium_max,
        potassium_min,
        potassium_max,
        abs_basophils_min,
        abs_basophils_max,
        abs_eosinophils_min,
        abs_eosinophils_max,
        abs_lymphocytes_min,
        abs_lymphocytes_max,
        abs_monocytes_min,
        abs_monocytes_max,
        abs_neutrophils_min,
        abs_neutrophils_max,
        atyps_min,
        atyps_max,
        bands_min,
        bands_max,
        imm_granulocytes_min,
        imm_granulocytes_max,
        metas_min,
        metas_max,
        nrbc_min,
        nrbc_max,
        d_dimer_min,
        d_dimer_max,
        fibrinogen_min,
        fibrinogen_min,
        thrombin_min,
        thrombin_max,
        inr_min,
        inr_max,
        pt_min,
        pt_max,
        ptt_min,
        ptt_max,
        alt_min,
        alt_max,
        alp_min,
        alp_max,
        ast_min,
        ast_max,
        amylase_min,
        amylase_max,
        bilirubin_total_min,
        bilirubin_total_max,
        bilirubin_direct_min,
        bilirubin_direct_max,
        bilirubin_indirect_min,
        bilirubin_indirect_max,
        ck_cpk_min,
        ck_cpk_max,
        ck_mb_min,
        ck_mb_max,
        ggt_min,
        ggt_max,
        ld_ldh_min,
        ld_ldh_max
    from
        first_day_lab
 )
 
 , vitalsign as (
    select 
        subject_id,
        stay_id,
        heart_rate_min,
        heart_rate_max,
        heart_rate_mean,
        sbp_min,
        sbp_max,
        sbp_max,
        dbp_min,
        dbp_max,
        dbp_mean,
        mbp_min,
        mbp_max,
        mbp_mean,
        resp_rate_min,
        resp_rate_max,
        resp_rate_max,
        temperature_min,
        temperature_max,
        temperature_mean,
        spo2_min,
        spo2_max,
        spo2_mean
    from
        first_day_vitalsign
)

, charlson as (
    SELECT
        subject_id,
        hadm_id,
        age_score,
        myocardial_infarct,
        congestive_heart_failure,
        peripheral_vascular_disease,
        cerebrovascular_disease,
        dementia,
        chronic_pulmonary_disease,
        rheumatic_disease,
        peptic_ulcer_disease,
        mild_liver_disease,
        diabetes_without_cc,
        diabetes_with_cc,
        paraplegia,
        renal_disease,
        malignant_cancer,
        severe_liver_disease,
        metastatic_solid_tumor,
        aids,
        charlson_comorbidity_index
    from
        charlson
)

SELECT 
    patients.subject_id
    , patients.gender
    , patients.dod
    , icustays.hadm_id
    , icustays.stay_id
    , lab.*
    , vitalsign.*
    , age.age
    , first_day_height.height
    , first_day_weight.weight
    , charlson.*
from
    patients,
    icustays,
    lab, vitalsign, age, first_day_height, first_day_weight, charlson
WHERE
 lab.subject_id = patients.subject_id 
 and lab.stay_id = icustays.stay_id 
 and icustays.subject_id = patients.subject_id 
 and vitalsign.subject_id = patients.subject_id 
 and vitalsign.stay_id = icustays.stay_id 
 and age.subject_id = patients.subject_id 
 and age.hadm_id = icustays.hadm_id 
 and first_day_height.subject_id = patients.subject_id 
 and first_day_height.stay_id = icustays.stay_id 
 and first_day_weight.subject_id = patients.subject_id 
 and first_day_weight.stay_id = icustays.stay_id 
 and charlson.subject_id = patients.subject_id 
 and charlson.hadm_id = icustays.hadm_id