SET search_path TO mimiciv_derived, mimiciv_hosp, mimiciv_icu, mimiciv_ed;
DROP TABLE IF EXISTS r_hosp_dataset; CREATE TABLE r_hosp_dataset AS
WITH main as ( SELECT
    patients.subject_id
    , patients.gender
    , patients.dod
    , admissions.hadm_id
    , age.age
FROM 
    patients,
    admissions,
    age
WHERE
    admissions.subject_id = patients.subject_id
    AND age.subject_id = patients.subject_id
    AND age.hadm_id = admissions.hadm_id
)
SELECT 
    main.subject_id
    , main.gender
    , main.dod
    , main.hadm_id
    , main.age
    --, bg2.charttime
    --, bg2.specimen
    , bg2.so2
    , bg2.po2
    , bg2.pco2
    , bg2.fio2
    , bg2.aado2
    -- acid-base parameters
    , bg2.ph
    , bg2.baseexcess
    , bg2.bicarbonate bg2_bicarbonate
    , bg2.totalco2

    -- blood count parameters
    , bg2.hematocrit bg2_hematocrit
    , bg2.hemoglobin bg2_haemoglobin
    , bg2.carboxyhemoglobin
    , bg2.methemoglobin

    -- chemistry
    , bg2.chloride bg2_chloride
    , bg2.calcium bg2_calcium
    , bg2.temperature
    , bg2.potassium bg2_potassium
    , bg2.sodium bg2_sodium
    , bg2.lactate bg2_lactate
    , bg2.glucose bg2_glucose
    , blood_differential2.wbc db_wbc
    , blood_differential2.basophils_abs
    , blood_differential2.eosinophils_abs
    , blood_differential2.lymphocytes_abs
    , blood_differential2.monocytes_abs
    , blood_differential2.neutrophils_abs
    , blood_differential2.basophils
    , blood_differential2.eosinophils
    , blood_differential2.lymphocytes
    , blood_differential2.monocytes
    , blood_differential2.neutrophils

    -- impute bands/blasts?
    , blood_differential2.atypical_lymphocytes
    , blood_differential2.bands
    , blood_differential2.immature_granulocytes
    , blood_differential2.metamyelocytes
    , blood_differential2.nrbc
    , cardiac_marker2.troponin_t
    , cardiac_marker2.ck_mb cm_ck_mb
    , cardiac_marker2.ntprobnp
    , chemistry2.albumin
    , chemistry2.globulin
    , chemistry2.total_protein
    , chemistry2.aniongap
    , chemistry2.bicarbonate
    , chemistry2.bun
    , chemistry2.calcium
    , chemistry2.chloride
    , chemistry2.creatinine
    , chemistry2.glucose
    , chemistry2.sodium
    , chemistry2.potassium
    , coagulation2.d_dimer
    , coagulation2.fibrinogen
    , coagulation2.thrombin
    , coagulation2.inr
    , coagulation2.pt
    , coagulation2.ptt
    , complete_blood_count2.hematocrit
    , complete_blood_count2.hemoglobin
    , complete_blood_count2.mch
    ,complete_blood_count2.mchc
    , complete_blood_count2.mcv
    , complete_blood_count2.platelet
    , complete_blood_count2.rbc
    , complete_blood_count2.rdw
    , complete_blood_count2.rdwsd
    , complete_blood_count2.wbc
    , creatinine_baseline.scr_min
    , creatinine_baseline.ckd
    , creatinine_baseline.mdrd_est
    , creatinine_baseline.scr_baseline
    , enzyme2.alt
    , enzyme2.alp
    , enzyme2.ast
    , enzyme2.amylase
    , enzyme2.bilirubin_total
    , enzyme2.bilirubin_direct
    , enzyme2.bilirubin_indirect
    , enzyme2.ck_cpk
    , enzyme2.ck_mb
    , enzyme2.ggt
    , enzyme2.ld_ldh
    , inflammation2.crp
    , charlson_comorbidity_index
from
    main
    LEFT JOIN bg2 ON bg2.subject_id = main.subject_id
        AND bg2.hadm_id = main.hadm_id
    LEFT JOIN blood_differential2 ON blood_differential2.hadm_id = main.hadm_id 
        AND blood_differential2.subject_id = main.subject_id 
    LEFT JOIN cardiac_marker2 ON cardiac_marker2.hadm_id = main.hadm_id
        AND cardiac_marker2.subject_id = main.subject_id
    LEFT JOIN chemistry2 ON chemistry2.hadm_id = main.hadm_id 
        AND chemistry2.subject_id = main.subject_id
    LEFT JOIN coagulation2 ON coagulation2.hadm_id = main.hadm_id
        AND coagulation2.subject_id = main.subject_id
    LEFT JOIN complete_blood_count2 ON complete_blood_count2.hadm_id = main.hadm_id
        AND complete_blood_count2.subject_id = main.subject_id
    LEFT JOIN creatinine_baseline ON creatinine_baseline.hadm_id = main.hadm_id
    LEFT JOIN enzyme2 ON enzyme2.hadm_id = main.hadm_id
        AND enzyme2.subject_id = main.subject_id
    LEFT JOIN inflammation2 ON inflammation2.hadm_id = main.hadm_id
        AND inflammation2.subject_id = main.subject_id
    LEFT JOIN charlson ON charlson.subject_id = main.subject_id
        AND charlson.hadm_id = main.hadm_id

