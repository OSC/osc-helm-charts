#!/bin/bash
#### CryoSPARC cluster submission script template for SLURM
## Available variables:
## {{ run_cmd }}            - complete command string to run the job
## {{ num_cpu }}            - number of CPUs needed
## {{ num_gpu }}            - number of GPUs needed
##                            Note: the code will use this many GPUs starting from dev id 0
##                                  the cluster scheduler or this script have the responsibility
##                                  of setting CUDA_VISIBLE_DEVICES so that the job code ends up
##                                  using the correct cluster-allocated GPUs.
## {{ ram_gb }}             - amount of RAM needed in GB
## {{ job_dir_abs }}        - absolute path to the job directory
## {{ project_dir_abs }}    - absolute path to the project dir
## {{ job_log_path_abs }}   - absolute path to the log file for the job
## {{ worker_bin_path }}    - absolute path to the cryosparc worker command
## {{ run_args }}           - arguments to be passed to cryosparcw run
## {{ project_uid }}        - uid of the project
## {{ job_uid }}            - uid of the job
## {{ job_creator }}        - name of the user that created the job (may contain spaces)
## {{ cryosparc_username }} - cryosparc username of the user that created the job (usually an email)
## {{ job_type }}           - cryosparc job type
##
## OSC customized variables
## {{ time }}               - time limit of the job (default: 60 minutes)
## {{ mem_gb }}             - amount of memory needed in GB. (default: 4GB x {{ num_cpu }})

#### What follows is a simple SLURM script:
#SBATCH --cluster=ascend
#SBATCH --account={{ account|default('REPLACE_ME_DEFAULT_ACCOUNT') }}
#SBATCH --job-name=cryosparc_{{ project_uid }}_{{ job_uid }}
#SBATCH --chdir={{ project_dir_abs }}
#SBATCH --time={{ (time|default(60)) }}
#SBATCH --output={{ job_dir_abs }}/output.txt
#SBATCH --error={{ job_dir_abs }}/error.txt
#SBATCH --export=ALL,LD_PRELOAD=
#SBATCH --nodes=1
#SBATCH --cpus-per-task={{ num_cpu }}
#SBATCH --ntasks-per-node={{ (ntasks_per_node|default(1)) }}
{%- if mem_gb %}
#SBATCH --mem={{ mem_gb|int }}gb
{%- endif %}
{%- if num_gpu > 0 %}
#SBATCH --gpus-per-node={{ num_gpu }}
{%- endif %}

export CRYOSPARC_SSD_PATH="$TMPDIR"
{{ run_cmd }}
