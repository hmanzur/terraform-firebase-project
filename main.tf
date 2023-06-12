/**
 * Create GCP Project
 *
 * @see https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/google_project
 */
resource "google_project" "this" {
  name            = var.project_name
  project_id      = var.project_id
  labels          = {
    provider = "terraform"
    firebase = "enabled"
  }
}

/*
 * Create Firebase Empty Project
 *
 * @see https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/firebase_project
 */
resource "google_firebase_project" "this" {
  provider = google-beta
  project  = google_project.this.project_id
}

/**
 * Create Firebase Web Application
 * @see https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/firebase_web_app
 */
resource "google_firebase_web_app" "basic" {
  provider     = google-beta
  project      = google_project.this.project_id
  display_name = google_project.this.name
}

/**
 * Enable Firestore Service API
 * @see https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/firebase_web_app
 */
resource "google_project_service" "firestore" {
  project = google_project.this.project_id
  service = "firestore.googleapis.com"
}

/**
 * Create Firestore Database
 * @see https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/firebase_web_app
 */
resource "google_firestore_database" "default" {
  project                     = google_project.this.project_id
  name                        = "(default)"
  location_id                 = "nam5"
  type                        = "FIRESTORE_NATIVE"
  concurrency_mode            = "OPTIMISTIC"
  app_engine_integration_mode = "DISABLED"

  depends_on = [google_project_service.firestore]
}
 

data "google_firebase_web_app_config" "basic" {
  provider   = google-beta
  web_app_id = google_firebase_web_app.basic.app_id
}
