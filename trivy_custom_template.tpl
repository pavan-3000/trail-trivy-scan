{{- define "vulnerabilitySeverityClass" -}}
  {{- if eq .Severity "CRITICAL" -}}critical{{- else if eq .Severity "HIGH" -}}high{{- else -}}normal{{- end -}}
{{- end -}}

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8" />
<title>Trivy Vulnerability Report</title>
<style>
  body {
    font-family: Arial, sans-serif;
  }
  .critical {
    background-color: #ff1a1a;
    color: white;
    font-weight: bold;
    border-left: 6px solid #b30000;
  }
  .high {
    background-color: #ffe066;
    color: black;
    font-weight: bold;
    border-left: 6px solid #ffcc00;
  }
  .normal {
    background-color: white;
    color: black;
  }
  table {
    border-collapse: collapse;
    width: 100%;
  }
  th, td {
    border: 1px solid #aaa;
    padding: 8px;
  }
  th {
    background-color: #f2f2f2;
  }
</style>
</head>
<body>
<h1>Trivy Vulnerability Report</h1>
<table>
  <thead>
    <tr>
      <th>Severity</th>
      <th>Vulnerability ID</th>
      <th>Pkg Name</th>
      <th>Installed Version</th>
      <th>Fixed Version</th>
      <th>Title</th>
    </tr>
  </thead>
  <tbody>
    {{- range .Vulnerabilities }}
    <tr class="{{ template "vulnerabilitySeverityClass" . }}">
      <td>{{ .Severity }}</td>
      <td>{{ .VulnerabilityID }}</td>
      <td>{{ .PkgName }}</td>
      <td>{{ .InstalledVersion }}</td>
      <td>{{ .FixedVersion }}</td>
      <td>{{ .Title }}</td>
    </tr>
    {{- end }}
  </tbody>
</table>
</body>
</html>
