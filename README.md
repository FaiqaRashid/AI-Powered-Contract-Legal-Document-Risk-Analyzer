# 🛡️ AI-Powered Contract & Legal Document Risk Analyzer

**TEYZIX CORE Internship (June Batch) — Task AI-3**
Domain: Artificial Intelligence | Difficulty: Advanced (Industry-Based)

An AI-powered web application that automatically analyzes legal documents (contracts, agreements, NDAs, leases, etc.), extracts key metadata, detects legal risks with confidence-scored explanations, and produces an executive summary — built with Google Gemini 2.5 Flash and a strict structured-output schema.

---

## 🚀 What It Does

1. **Register / Log in** — accounts are stored in Supabase with hashed passwords and a `user`/`admin` role
2. **Upload** a contract in PDF, DOCX, or TXT format
3. The system extracts the text and sends it to Gemini 2.5 Flash under a legal-counsel persona prompt
4. Returns a **strictly typed, schema-validated** analysis (via Pydantic) containing:
   - Contract type, parties, effective/expiry dates
   - Payment terms, renewal clause, confidentiality clause, termination clause
   - Responsibilities, key obligations, and recommended actions
   - An overall document risk score (0–100)
   - A structured list of detected risks — each with a title, severity (High/Medium/Low), a 0–100 AI confidence score, and a plain-language explanation
5. **Ask questions** about the uploaded document in natural language (lightweight semantic search / Q&A over the document text)
6. **Export** the full report as a **PDF** or **DOCX**
7. **Save** the analysis to cloud history (Supabase) and browse **past analyses** in the History tab
8. View an **AI Insights Dashboard** — total documents analyzed, average risk score, high-risk document count, and most frequently detected risk types
9. **Admins** get a dedicated panel to view all registered users, system-wide processing stats, and recent activity logs

---

## 🧱 Tech Stack

| Layer | Technology |
|---|---|
| Frontend / UI | Streamlit |
| LLM | Google Gemini 2.5 Flash (`google-genai` SDK) |
| Structured Output | Pydantic schemas + Gemini's native `response_schema` enforcement |
| Document Parsing | `pypdf` (PDF), `python-docx` (DOCX), native (TXT) |
| Report Export | `reportlab` (PDF), `python-docx` (DOCX) |
| Auth & Persistence | Supabase (PostgreSQL) — custom `app_users` + `legal_contract_analyses` tables |
| Config | `python-dotenv` |

---

## 📂 Project Structure

```
├── app.py                 # Main Streamlit application
├── supabase_schema.sql    # SQL to create the required Supabase tables
├── .env.example           # API keys 
├── requirements.txt       # Python dependencies
├── sample_documents/      # Sample contracts for testing (txt, pdf, docx)
└── README.md
```

---

## ⚙️ Setup Instructions

### 1. Clone the repository
```bash
git clone <your-repo-url>
cd <repo-folder>
```

### 2. Install dependencies
```bash
pip install -r requirements.txt
```

### 3. Configure environment variables
Create a `.env` file in the project root:
```env
GEMINI_API_KEY=your_google_gemini_api_key
SUPABASE_URL=your_supabase_project_url
SUPABASE_KEY=your_supabase_service_or_anon_key
```

### 4. Set up the Supabase tables
Run `supabase_schema.sql` (included in this repo) in your Supabase project's SQL editor. It creates:
- `app_users` — username, email, hashed password, and role (`user`/`admin`)
- `legal_contract_analyses` — every saved analysis, linked to the uploading user

To make your own account an admin (unlocks the Admin Panel), run after registering once:
```sql
update app_users set role = 'admin' where username = 'your_username';
```

### 5. Run the app
```bash
streamlit run app.py
```

### 6. First use
Register an account from the login screen, log in, upload a sample document from `sample_documents/`, and run an audit.

---

## 🧪 How to Test

Sample contracts of varying risk levels are included in `sample_documents/` (low, medium, and high-risk examples across NDAs, employment contracts, leases, loan agreements, vendor agreements, and more) — covering `.txt`, `.docx`, and `.pdf` formats to validate the full extraction pipeline.

1. Launch the app
2. Upload any sample document
3. Click **"Execute AI Corporate Contract Audit"**
4. Review the extracted metadata, executive summary, and flagged risks

---

## ✅ Implemented Features

- [x] User registration & login (Supabase-backed, hashed passwords)
- [x] Role-based access control (`user` vs `admin`, with a dedicated Admin Panel)
- [x] User profile display in sidebar (username, email, role)
- [x] Multi-format document upload & text extraction (PDF, DOCX, TXT)
- [x] AI-based contract metadata extraction (type, parties, dates)
- [x] AI-based extraction of payment terms, renewal, confidentiality, and termination clauses
- [x] AI-generated responsibilities, key obligations, and recommended actions
- [x] AI-based risk detection with severity + confidence score + explanation
- [x] Overall document risk score (0–100)
- [x] Structured, schema-validated LLM output (no free-text parsing errors)
- [x] Lightweight semantic search / natural-language Q&A over the uploaded document
- [x] Exportable PDF and DOCX audit reports
- [x] Cloud audit logging via Supabase
- [x] In-app document history browser (per-user, or all documents for admins)
- [x] AI Insights Dashboard (total documents, average risk score, high-risk count, most frequent risks)
- [x] Admin panel — view users, system-wide stats, and recent processing logs
- [x] Clean, color-coded risk dashboard UI

## 🗺️ Roadmap (Future Enhancements)

- [ ] True vector-database-backed semantic search (ChromaDB/FAISS) across the full document history, not just the currently loaded document
- [ ] Multi-language document analysis
- [ ] OCR support for scanned PDF contracts
- [ ] AI clause comparison / version diffing between contract revisions
- [ ] Email report delivery
- [ ] Docker deployment

---

## 🔐 Notes on Security

- API keys and Supabase credentials are loaded from environment variables and never hard-coded
- Uploaded file content is processed in-memory and not persisted to local disk

---

## 👩‍💻 Author

Faiqa — AI/NLP Intern, TEYZIX CORE
Final-year Computer Science student
