set -euox
set
if [[ -n "${ORB_PARAM_NAMESPACE}" ]]; then
	set -- "$@" --namespace="${ORB_PARAM_NAMESPACE}"
fi
if [[ -n "${TIMEOUT}" ]]; then
	set -- "$@" --timeout "${TIMEOUT}"
fi
if [[ "${NO_HOOKS}" == true ]]; then
	set -- "$@" --no-hooks
fi
if [[ "${ATOMIC}" == true ]]; then
	set -- "$@" --atomic
fi
if [[ "${ORB_PARAM_WAIT}" == true ]]; then
	set -- "$@" --wait
fi
if [[ "${DEVEL}" == true ]]; then
	set -- "$@" --devel
fi
if [[ "${DRY_RUN}" == true ]]; then
	set -- "$@" --dry-run
fi
if [[ "${RESET_VALUES}" == true ]]; then
	set -- "$@" --reset-values
fi
if [[ "${REUSE_VALUES}" == true ]]; then
	set -- "$@" --reuse-values
fi
if [[ -n "${VALUES}" ]]; then
	set -- "$@" --values "$(eval "${VALUES}")"
fi
if [[ -n "${VALUES_TO_OVERRIDE}" ]]; then
	set -- "$@" --set "$(eval "${VALUES_TO_OVERRIDE}")"
fi
if [[ -n "${VERSION}" ]]; then
	set -- "$@" --version="$(eval "${VERSION}")"
fi

helm repo add "${ORB_PARAM_RELEASE_NAME}" "${ORB_PARAM_REPO}"
helm repo update

CMD=("helm upgrade --install ${ORB_PARAM_RELEASE_NAME} ${ORB_PARAM_CHART} $@")

echo "${CMD[@]}"

"${CMD[@]}" || exit 1
