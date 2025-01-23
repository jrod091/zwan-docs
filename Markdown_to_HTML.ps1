# Check if the MarkdownToHtml module is installed
if (-not (Get-Module -ListAvailable -Name MarkdownToHtml)) {
    Write-Host "The MarkdownToHtml module is not installed. Please install it using 'Install-Module -Name MarkdownToHtml'." -ForegroundColor Red
    exit
}

# Function to convert Markdown to HTML
function Convert-MarkdownToHtml {
    param (
        [Parameter(Mandatory = $true, HelpMessage = "Path to the Markdown file (.md)")]
        [string]$MarkdownFile,

        [Parameter(Mandatory = $true, HelpMessage = "Output directory for the HTML file")]
        [string]$OutputDirectory
    )

    # Check if the input Markdown file exists
    if (-not (Test-Path -Path $MarkdownFile)) {
        Write-Host "The specified Markdown file does not exist: $MarkdownFile" -ForegroundColor Red
        exit
    }

    # Ensure the output directory exists; if not, create it
    if (-not (Test-Path -Path $OutputDirectory)) {
        Write-Host "The specified output directory does not exist. Creating it: $OutputDirectory" -ForegroundColor Yellow
        New-Item -ItemType Directory -Path $OutputDirectory | Out-Null
    }

    # Import the module
    Import-Module -Name MarkdownToHtml -ErrorAction Stop

    # Read the Markdown file
    $MarkdownContent = Get-Content -Path $MarkdownFile -Raw

    # Convert Markdown to HTML
    $HtmlContent = ConvertTo-HtmlMarkdown -Markdown $MarkdownContent

    # Determine the output HTML file name
    $FileName = [System.IO.Path]::GetFileNameWithoutExtension($MarkdownFile)
    $OutputFile = Join-Path -Path $OutputDirectory -ChildPath "$FileName.html"

    # Save the HTML content to the output file
    $HtmlContent | Set-Content -Path $OutputFile -Encoding UTF8

    Write-Host "Markdown file successfully converted to HTML: $OutputFile" -ForegroundColor Green
}

# Prompt user for input
$MarkdownFile = Read-Host "Enter the path to the Markdown file (.md)"
$OutputDirectory = Read-Host "Enter the output directory for the HTML file"

# Call the function
Convert-MarkdownToHtml -MarkdownFile $MarkdownFile -OutputDirectory $OutputDirectory