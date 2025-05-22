{{- define "content" -}}
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Trivy Scan Report</title>
    <style>
        body { font-family: Arial, sans-serif; margin: 20px; }
        h1 { color: #333; }
        table { width: 100%; border-collapse: collapse; margin-top: 20px; }
        th, td { border: 1px solid #ddd; padding: 8px; text-align: left; }
        th { background-color: #f4f4f4; }
        .CRITICAL { background-color: #ffcccc; font-weight: bold; }
        .HIGH { background-color: #ffe0b3; }
    </style>
</head>
<body>
    <h1>Trivy Vulnerability Report for {{ .ArtifactName }}</h1>
    <table>
        <tr>
            <th>Vulnerability ID</th>
            <th>Package</th>
            <th>Installed Version</th>
            <th>Fixed Version</th>
            <th>Severity</th>
            <th>Title</th>
        </tr>
        {{ range .Results }}
            {{ range .Vulnerabilities }}
            <tr class="{{ .Severity }}">
                <td>{{ .VulnerabilityID }}</td>
                <td>{{ .PkgName }}</td>
                <td>{{ .InstalledVersion }}</td>
                <td>{{ .FixedVersion }}</td>
                <td>{{ .Severity }}</td>
                <td>{{ .Title }}</td>
            </tr>
            {{ end }}
        {{ end }}
    </table>
</body>
</html>
{{- end -}}
