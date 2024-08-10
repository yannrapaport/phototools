#!/bin/bash
#  ptt-cleanup.sh
#
#  Created by Yann Rapaport on 30/07/2018.
#

source "$(dirname "$0")/ptt-lib.inc"

# Variables
RM_DIRS=()
DEFAULT_ACTION="all"
USE_PAGER=true

# Fonction usage
usage() {
    echo "Usage: $0 [--export | --empty | --all] [--pager | --nopager]"
    echo
    echo "Options:"
    echo "  --export     Supprime les répertoires export, même s'ils ne sont pas vides."
    echo "  --empty      Supprime uniquement les répertoires vides."
    echo "  --all        Supprime les répertoires export et vides. (par défaut)"
    echo "  --pager      Utilise un pager pour afficher la liste des répertoires avant confirmation. (par défaut)"
    echo "  --nopager    N'utilise pas de pager."
    echo
    exit 1
}

# Parse les options
ACTION=""
PAGER_OPTION_SET=false

for arg in "$@"; do
    case $arg in
        --export)
            if [ -n "$ACTION" ]; then
                echo "Erreur: Les options --export, --empty et --all sont mutuellement exclusives."
                usage
            fi
            ACTION="export"
            ;;
        --empty)
            if [ -n "$ACTION" ]; then
                echo "Erreur: Les options --export, --empty et --all sont mutuellement exclusives."
                usage
            fi
            ACTION="empty"
            ;;
        --all)
            if [ -n "$ACTION" ]; then
                echo "Erreur: Les options --export, --empty et --all sont mutuellement exclusives."
                usage
            fi
            ACTION="all"
            ;;
        --pager)
            if [ "$PAGER_OPTION_SET" = true ]; then
                echo "Erreur: Les options --pager et --nopager sont mutuellement exclusives."
                usage
            fi
            USE_PAGER=true
            PAGER_OPTION_SET=true
            ;;
        --nopager)
            if [ "$PAGER_OPTION_SET" = true ]; then
                echo "Erreur: Les options --pager et --nopager sont mutuellement exclusives."
                usage
            fi
            USE_PAGER=false
            PAGER_OPTION_SET=true
            ;;
        --help)
            usage
            ;;
        *)
            echo "Option inconnue : $arg"
            usage
            ;;
    esac
done

# Si aucune action n'a été spécifiée, on utilise l'action par défaut
if [ -z "$ACTION" ]; then
    ACTION=$DEFAULT_ACTION
fi

# Collecte les répertoires à supprimer
if [ "$ACTION" = "export" ] || [ "$ACTION" = "all" ]; then
    while IFS= read -r -d '' dir; do
        RM_DIRS+=("$dir")
    done < <(find . -name "export" -print0 2>/dev/null)
fi

if [ "$ACTION" = "empty" ] || [ "$ACTION" = "all" ]; then
    while IFS= read -r -d '' dir; do
        RM_DIRS+=("$dir")
    done < <(find . -empty -print0 2>/dev/null)
fi

if [ ${#RM_DIRS[@]} -eq 0 ]; then
    echo "Aucun répertoire correspondant trouvé; sortie."
    exit
fi

# Affiche la liste des répertoires à supprimer avec ou sans pager
echo "Les répertoires suivants seront supprimés :"
if [ "$USE_PAGER" = true ]; then
    printf '%s\n' "${RM_DIRS[@]}" | less
else
    printf '%s\n' "${RM_DIRS[@]}"
fi

# Confirmation de suppression
echo "Continuer (Y/n)?"
read -r ans

case $ans in
    n|N)    exit;;
    ""|Y|y) rm -rf "${RM_DIRS[@]}";;
    *)      echo "Réponse non reconnue : $ans";;
esac

