<h1 align="center">Myelin map from the T1w/T2w ratio</h1>

<p align="center">
  A volumetric myelin map computed as the ratio of a T1-weighted to a T2-weighted image with Connectome Workbench.
</p>

<p align="center">
  <a href="https://github.com/brainlife/abcd-spec"><img src="https://img.shields.io/badge/ABCD_Spec-v1.1-green.svg" alt="ABCD Spec v1.1"></a>
  <a href="https://doi.org/10.25663/brainlife.app.478"><img src="https://img.shields.io/badge/Brainlife-brainlife.app.478-blue.svg" alt="Run on brainlife.io"></a>
  <a href="https://github.com/brainlife/app-myelin-mapping/blob/main/LICENSE"><img src="https://img.shields.io/badge/License-MIT-lightgrey.svg" alt="MIT license"></a>
</p>

> **This branch, `t1-t2-ratio-v1.0`, is the brainlife.io App Compute myelin map using T1w / T2w ratio** ([doi:10.25663/brainlife.app.478](https://doi.org/10.25663/brainlife.app.478)).

## At a glance

<!-- brainlife-app:begin (generated from the App manifest; edit the manifest, not this block) -->

> **Computes a volumetric myelin map as the T1w/T2w ratio (Glasser and Van Essen 2011) with Connectome Workbench and outputs a myelin-map datatype.**

Divides the T1-weighted by the T2-weighted image voxel-wise with wb_command -volume-math, clamping to 0-100 and setting NaNs to 0; optionally reslices the T2 to the T1 grid with FreeSurfer mri_vol2vol first. Use it for a quick myelin-content proxy. Both images must be aligned (the reslice option only resamples by header, it does not register); no bias-field correction is applied.

| | |
|---|---|
| **Inputs** | `neuro/anat/t1w` · `neuro/anat/t2w` |
| **Outputs** | `neuro/myelin-map` |
| **Container** | `brainlife/connectome_workbench:1.4.2b` |
| **Resources** | 1 CPUs · 0.5 h walltime |
| **Requires** | `FREESURFER_LICENSE` |
| **Run it** | [doi.org/10.25663/brainlife.app.478](https://doi.org/10.25663/brainlife.app.478) |

#### Inputs

| Input | Datatype | Required | Description |
|---|---|---|---|
| `t1` | `neuro/anat/t1w` | yes | T1-weighted image. |
| `t2` | `neuro/anat/t2w` | yes | T2-weighted image of the same subject. Must be aligned to the T1; on the same voxel grid unless reslice is true. |

#### Outputs

| Output | Datatype | Description |
|---|---|---|
| `output` | `neuro/myelin-map` | Myelin map (map.nii.gz): the T1w/T2w ratio clamped to 0-100. |

<details>
<summary><b>Parameters</b> (1)</summary>

| Parameter | Type | Default | Description |
|---|---|---|---|
| `reslice` | boolean | `false` | If true, will use mri_vol2vol from Freesurfer to align and reslice the t2 to the t1 space before computing ratio |

</details>

<!-- brainlife-app:end -->

## Running the App

### On brainlife.io

Open the App at [doi.org/10.25663/brainlife.app.478](https://doi.org/10.25663/brainlife.app.478), choose a T1-weighted and a T2-weighted image of the same subject from your project and press **Execute**. The myelin map is archived to your project as a `neuro/myelin-map` dataset tagged `t1-t2-ratio`.

The App divides the T1-weighted image by the T2-weighted image voxel by voxel (`wb_command -volume-math`), clamps the result to 0–100 and sets NaNs to 0. No bias-field correction is applied. The two images must be aligned; if they are on different voxel grids, set `reslice` to resample the T2 onto the T1 grid with FreeSurfer `mri_vol2vol` first (this uses the image headers only and does not register the images).

### Locally

You need [Singularity/Apptainer](https://apptainer.org/), [`jq`](https://jqlang.github.io/jq/) and a [FreeSurfer license](https://surfer.nmr.mgh.harvard.edu/registration.html) (used by the `reslice` step).

1. Clone this repository and check out the branch used on brainlife.io: `git checkout t1-t2-ratio-v1.0`.
2. Create `config.json` with the paths to your inputs:

   ```json
   {
       "t1": "/input/t1/t1.nii.gz",
       "t2": "/input/t2/t2.nii.gz",
       "reslice": false
   }
   ```

3. Export your license and run the App:

   ```bash
   export FREESURFER_LICENSE="$(cat ~/freesurfer/license.txt)"
   ./main
   ```

## Outputs

```text
output/
└── map.nii.gz   T1w/T2w ratio, clamped to 0–100 (neuro/myelin-map)
```

## Troubleshooting

- **`Please set FREESURFER_LICENSE in .bashrc`**: export the `FREESURFER_LICENSE` environment variable before running `./main` (brainlife.io provides it automatically).
- **`app failed. check logs`**: `map.nii.gz` was not written, most often because the T1 and T2 images are on different voxel grids. Set `reslice` to `true`, and make sure the images are aligned beforehand.

## Citing

> [!TIP]
> If you use this App in your work, please cite the App, the software it builds on and brainlife.io (below). GitHub's **Cite this repository** button gives the App citation in APA and BibTeX.

- Glasser MF, Van Essen DC. Mapping human cortical areas in vivo based on myelin content as revealed by T1- and T2-weighted MRI. *Journal of Neuroscience* 31(32):11597–11616 (2011). [doi:10.1523/JNEUROSCI.2180-11.2011](https://doi.org/10.1523/JNEUROSCI.2180-11.2011)
- Compute myelin map using T1w / T2w ratio. brainlife.io App. [doi:10.25663/brainlife.app.478](https://doi.org/10.25663/brainlife.app.478)
- Avesani P, McPherson B, Hayashi S, et al. The open diffusion data derivatives, brain data upcycling via integrated publishing of derivatives and reproducible open cloud services. Sci Data 6, 69 (2019). [doi:10.1038/s41597-019-0073-y](https://doi.org/10.1038/s41597-019-0073-y)
- Fischl. FreeSurfer. *NeuroImage* 62:774-781 (2012). [doi:10.1016/j.neuroimage.2012.01.021](https://doi.org/10.1016/j.neuroimage.2012.01.021)
- Marcus et al. Informatics and Data Mining Tools and Strategies for the Human Connectome Project. *Frontiers in Neuroinformatics* 5 (2011). [doi:10.3389/fninf.2011.00004](https://doi.org/10.3389/fninf.2011.00004)
- Hayashi S, Caron BA, Heinsfeld AS, et al. brainlife.io: a decentralized and open-source cloud platform to support neuroscience research. *Nature Methods* 21:809–813 (2024). [doi:10.1038/s41592-024-02237-2](https://doi.org/10.1038/s41592-024-02237-2)

## Authors

- Brad Caron

## Funding

[![Wellcome-226486/Z/22/Z](https://img.shields.io/badge/Wellcome-226486%2FZ%2F22%2FZ-purple.svg)](https://wellcome.org/)
[![NIH-NINDS-U24NS140384](https://img.shields.io/badge/NIH_NINDS-U24NS140384-green.svg)](https://reporter.nih.gov/project-details/11261037)
[![NIH-NINDS-UM1NS132207](https://img.shields.io/badge/NIH_NINDS-UM1NS132207-green.svg)](https://reporter.nih.gov/project-details/11411328)
[![NIH-NIBIB-R01EB029272](https://img.shields.io/badge/NIH_NIBIB-R01EB029272-green.svg)](https://reporter.nih.gov/project-details/10262925)
[![NIH-NIBIB-R01EB030896](https://img.shields.io/badge/NIH_NIBIB-R01EB030896-green.svg)](https://reporter.nih.gov/project-details/10428625)
[![NIH-NIMH-R01MH126699](https://img.shields.io/badge/NIH_NIMH-R01MH126699-green.svg)](https://reporter.nih.gov/project-details/10460628)
[![NIH-NIDCD-R01DC020088](https://img.shields.io/badge/NIH_NIDCD-R01DC020088-green.svg)](https://reporter.nih.gov/project-details/11140284)
[![NSF-BCS-1734853](https://img.shields.io/badge/NSF_BCS-1734853-blue.svg)](https://www.nsf.gov/awardsearch/showAward?AWD_ID=1734853)
[![NSF-BCS-2203524](https://img.shields.io/badge/NSF_BCS-2203524-blue.svg)](https://www.nsf.gov/awardsearch/showAward?AWD_ID=2203524)
[![NSF-IIS-1636893](https://img.shields.io/badge/NSF_IIS-1636893-blue.svg)](https://www.nsf.gov/awardsearch/showAward?AWD_ID=1636893)
[![NSF-OAC-2148729](https://img.shields.io/badge/NSF_OAC-2148729-blue.svg)](https://www.nsf.gov/awardsearch/showAward?AWD_ID=2148729)
[![NSF-IIS-1912270](https://img.shields.io/badge/NSF_IIS-1912270-blue.svg)](https://www.nsf.gov/awardsearch/showAward?AWD_ID=1912270)
[![NSF-IIS-2148700](https://img.shields.io/badge/NSF_IIS-2148700-blue.svg)](https://www.nsf.gov/awardsearch/showAward?AWD_ID=2148700)
[![NSF-OAC-1916518](https://img.shields.io/badge/NSF_OAC-1916518-blue.svg)](https://www.nsf.gov/awardsearch/showAward?AWD_ID=1916518)

<sub>brainlife.io is publicly funded, and acknowledging that support helps keep it running. This App was developed with support from Wellcome, the U.S. National Institutes of Health (including the BRAIN Initiative BRAIN CONNECTS program: The Axonal Projectome EXchange, U24NS140384, and the Center for Mesoscale Connectomics, UM1NS132207) and the U.S. National Science Foundation.</sub>

## License

[MIT](https://github.com/brainlife/app-myelin-mapping/blob/main/LICENSE). Connectome Workbench and FreeSurfer are distributed under their own licenses.
