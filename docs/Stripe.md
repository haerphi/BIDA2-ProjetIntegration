# Stripe

## Contexte

Le paiement se fait via Stripe en utilisant le package payments

## Installation

### Création des clés API

S'inscrire sur [Stripe](https://stripe.com/) et récupérer les clés API (si mode teste, cliquer sur la bannière pour activer le mode test)

Récupérer les clés API:

- Stripe Secret Key: `sk_test_xxxxx`
- Stripe Publishable Key: `pk_test_xxxxx`
- Stripe Webhook Secret: `whsec_xxxxx` (si en mode production)

### (LOCAL - docker) Création de lien de webhook

Utilisé l'image `stripe/stripe-cli` pour ne pas avoir à installer stripe sur sa machine
Il faudra absolument la variable "STRIPE_API_KEY" pour pouvoir obtenir le "STRIPE_WEBHOOK_SECRET"

### Backend

Dans le .env ajouter les clés API:

```env
STRIPE_API_KEY=sk_test_xxxxx
STRIPE_WEBHOOK_SECRET=whsec_xxxxx
```

### Frontend

Dans le .env.local ajouter les clés API:

```env
VITE_STRIPE_PUBLISHABLE_KEY=pk_test_xxxxx
```
