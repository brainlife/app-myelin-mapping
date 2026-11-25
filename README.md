<!-- brainlife-app:begin (generated from the App manifest; edit the manifest, not this block) -->

**Computes a volumetric myelin map as the T1w/T2w ratio (Glasser and Van Essen 2011) with Connectome Workbench and outputs a myelin-map datatype.**

Divides the T1-weighted by the T2-weighted image voxel-wise with wb_command -volume-math, clamping to 0-100 and setting NaNs to 0; optionally reslices the T2 to the T1 grid with FreeSurfer mri_vol2vol first. Use it for a quick myelin-content proxy. Both images must be aligned (the reslice option only resamples by header, it does not register); no bias-field correction is applied.

Run it on brainlife.io: [https://doi.org/10.25663/brainlife.app.478](https://doi.org/10.25663/brainlife.app.478)

| Input | Datatype | Required | Description |
|---|---|---|---|
| `t1` | `neuro/anat/t1w` | yes | T1-weighted image. |
| `t2` | `neuro/anat/t2w` | yes | T2-weighted image of the same subject. Must be aligned to the T1; on the same voxel grid unless reslice is true. |

| Output | Datatype | Description |
|---|---|---|
| `output` | `neuro/myelin-map` | Myelin map (map.nii.gz): the T1w/T2w ratio clamped to 0-100. |

| Parameter | Type | Default | Description |
|---|---|---|---|
| `reslice` | boolean | `false` | If true, will use mri_vol2vol from Freesurfer to align and reslice the t2 to the t1 space before computing ratio |

Runtime: container `brainlife/connectome_workbench:1.4.2b`; 1 CPUs; 0.5 h walltime; needs `FREESURFER_LICENSE`.

Please cite:
- Avesani P, McPherson B, Hayashi S, et al. The open diffusion data derivatives, brain data upcycling via integrated publishing of derivatives and reproducible open cloud services. Sci Data 6, 69 (2019). [doi:10.1038/s41597-019-0073-y](https://doi.org/10.1038/s41597-019-0073-y)
- Glasser MF, Van Essen DC. Mapping human cortical areas in vivo based on myelin content as revealed by T1- and T2-weighted MRI. J Neurosci 31(32):11597-11616 (2011). [doi:10.1523/JNEUROSCI.2180-11.2011](https://doi.org/10.1523/JNEUROSCI.2180-11.2011)

<!-- brainlife-app:end -->

# myelin-mapping