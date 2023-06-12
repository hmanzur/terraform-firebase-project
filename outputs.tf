output "console" {
  value = "https://console.firebase.google.com/project/${google_project.this.project_id}/overview"
}

output "website" {
  value = "https://${module.firebase.hosting_url}"
}

output "project" {
  value = google_project.this.project_id
}

output "config" {
  value = {
    projectId         = google_project.this.project_id
    appId             = google_firebase_web_app.basic.app_id
    apiKey            = data.google_firebase_web_app_config.basic.api_key
    authDomain        = data.google_firebase_web_app_config.basic.auth_domain
    storageBucket     = lookup(data.google_firebase_web_app_config.basic, "storage_bucket", "")
    messagingSenderId = lookup(data.google_firebase_web_app_config.basic, "messaging_sender_id", "")
  }
}