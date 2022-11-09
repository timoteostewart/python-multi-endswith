
$cur_dir = Get-Location
$possible_which_python = $cur_dir.tostring() + "\.venv\Scripts\python"

$actual_which_python = which python

if ($actual_which_python.Contains($possible_which_python)) {
    Write-Host "already in .venv"
    python -m pip install --upgrade pip
    pip install black isort
    Exit 0
}

if (Test-Path -Path ".venv") {
    Write-Host ".venv already exists, so starting it"
} else {
    Write-Host ".venv doesn't exist, so creating it"
    python -m venv .venv
    Start-Sleep -Seconds 10
}

& .\.venv\Scripts\Activate.ps1

$actual_which_python = which python

if ($actual_which_python.Contains($possible_which_python)) {
    Write-Host "upgrading pip"
    python -m pip install --upgrade pip
    pip install black isort
    Exit 0
} else {
    Write-Host "could not start .venv, so did not upgrade pip"
    Exit 1
}
