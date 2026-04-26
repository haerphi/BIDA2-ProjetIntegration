# Connexion via Google

## Contexte

Laissé la possiblité à l'utilisateur de se connecter via son compte Google sans devoir écrire son mot de passe.

_Note: dasn cette application, le compte doit déjà être créer au préalable par un administrateur._

## Installtion

### Création d'un Google OAuth2 Client ID

1. Aller sur [Google Cloud Console](https://console.cloud.google.com/).
2. Créer un nouveau projet.
3. Séléctionner "APIs & Services" > "OAuth consent screen".
4. "Get started", remplir le formulaire
   - App Information name: "BIDA2-tennis-club-Auth"
   - email
   - Selectionner "external User Type" pour que n'importe qui puisse utiliser son adresse gmail et non pas uniquement des emails de l'entreprise
5. Séléctionner "APIs & Services" > "OAuth consent screen".
6. "+ Create Credentials" et puis sélectionner "OAuth client ID"
   - Sélectionner "Web application"
   - ajouté "Authorized JavaScript origins" avec la valeur "http://localhost:5173"
   - "Create"
7. Télécharger le fichier JSON et le garder précieusement quelque part SANS LE PARTAGER!!!!
8. Récupérer le "GOOGLE_CLIENT_ID" et le "GOOGLE_CLIENT_SECRET" pour le placer dans le `.env`

### Backend

#### Installation des dépendances

Ajouter la librairie Google et Requests

```bash
poetry add google-auth requests
```

#### Variables d'environnement

Vérifier que dans le `.env` il y a bien "GOOGLE_CLIENT_ID" et "GOOGLE_CLIENT_SECRET" avec les informations du JSON

Dans `src/core/settings/base.py`, configurer la varialbe d'environnement:

```python
GOOGLE_CLIENT_ID = env('GOOGLE_CLIENT_ID', default='')
```

#### Implémenter une vue (`src/core/views.py`)

- **`GoogleLoginSerializer`**: Schéma pour "DRF Specular".
- **`GoogleLoginView`** qui va:
  - récupérer et convertir le `token` provenant du body de la requête
  - utilisé la fonction `google.oauth2.id_token.verify_oauth2_token` du package google pour vérifier si la cryptographie du token est valide et provient bien de notre application
  - extrait l'email et rechercher dans la DB si on a un user avec son email
  - génération du token de connexion comme s'il s'était connecté avec son username et mot de passe
- Enregistrement de la nouvelle route dans `src/core/urls.py`

### Frontend

#### Installation de la dépendance

Installation de la dépendance pour facilité l'intégration:

```bash
npm i @react-oauth/google
```

#### Création du composant

Utilisation du composant "GoogleOAuthProvider" et "GoogleLogin" qui proviennent du package.

```tsx
import {
  GoogleOAuthProvider,
  GoogleLogin,
  type CredentialResponse,
} from "@react-oauth/google";

const clientId = import.meta.env.VITE_GOOGLE_CLIENT_ID;

function GoogleButton() {
  const handleGoogleSuccess = async (
    credentialResponse: CredentialResponse,
  ) => {
    // Send the token to your API for validation and user creation/login
    const response = await fetch(
      `${import.meta.env.VITE_API_URL}/token/google/`,
      {
        method: "POST",
        headers: {
          "Content-Type": "application/json",
        },
        body: JSON.stringify({ token: credentialResponse.credential }),
      },
    );

    const data = await response.json();
    // Handle successful login (e.g., save JWT, redirect)
    console.log(data);
  };

  return (
    <GoogleOAuthProvider clientId={clientId}>
      <div className="login-container">
        {/* Your existing login form goes here */}

        <div className="google-login-button">
          <GoogleLogin
            onSuccess={handleGoogleSuccess}
            onError={() => {
              console.log("Login Failed");
            }}
          />
        </div>
      </div>
    </GoogleOAuthProvider>
  );
}

export default GoogleButton;
```

Avec data, mettre à jour le state de l'application
