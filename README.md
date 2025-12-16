# 🧩 Projet Rubik's Cube

## 🎯 Présentation du projet

Voici notre projet de **2ème année** :  
Un **robot solveur de Rubik’s Cube automatique**.

L’objectif est de **concevoir un robot capable de résoudre un Rubik’s Cube rapidement**, tout en conservant une **structure compacte et portable**.

Nous disposons déjà du **montage** réalisé par nos prédécesseurs ainsi que des **composants associés** (drivers, moteurs pas à pas, etc.).  
Cependant, **de nouveaux composants** pourront être commandés en raison du **volume important** de certains éléments.

---

## 📋 Cahier des charges

| Critère | Spécification |
|----------|----------------|
| **Vitesse de résolution** | ≤ 20 s |
| **Budget** | 160 € |
| **Taille** | Compacte |

---

## 💡 Solutions préconisées

- **Calcul et commande :**  
  L’**algorithme de résolution** et la **commande des moteurs** seront gérés par un **FPGA-SoC**.

- **Mouvement :**  
  Les **rotations du cube** seront effectuées par des **moteurs pas à pas** et leurs **drivers respectifs**.

- **Alimentation :**  
  Le montage sera **alimenté par des batteries**.

- **Structure :**  
  Nous prévoyons une **structure en forme d’anneau**, capable de **se déployer autour du Rubik’s Cube**.

---

## 📆 Progression du projet

**Date : 09/12/2025**

- ✅ L’**algorithme de résolution** est trouvé  
- ✅ Le **code VHDL** est rédigé et validé en simulation
- 🧩 La **communication entre le FPGA et le Processeur** est en cours de développement -> Test éventuel avec carte le 16
- 🧾 Une **liste de composants** a été dressée
- Les PCB des drivers sont conçus
- La structure est en cours de développement avec quelques parties d'ores et déjà imprimées.

---


