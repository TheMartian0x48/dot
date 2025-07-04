#!/bin/bash

# Custom jdtls launcher with Lombok support
# Ensures -javaagent comes before -jar for proper Lombok integration

# Paths
JDTLS_HOME="$HOME/.local/share/nvim/mason/packages/jdtls"
LOMBOK_PATH="$HOME/.config/nvim/lang-servers/java/lombok.jar"

# Find the launcher JAR (it has a version number in the name)
LAUNCHER_JAR=$(find "$JDTLS_HOME/plugins" -name "org.eclipse.equinox.launcher_*.jar" | head -1)

if [ ! -f "$LAUNCHER_JAR" ]; then
    echo "Error: Could not find jdtls launcher JAR in $JDTLS_HOME/plugins"
    exit 1
fi

if [ ! -f "$LOMBOK_PATH" ]; then
    echo "Error: Could not find Lombok JAR at $LOMBOK_PATH"
    exit 1
fi

# Execute Java with correct argument order: -javaagent BEFORE -jar
exec java \
    -Declipse.application=org.eclipse.jdt.ls.core.id1 \
    -Dosgi.bundles.defaultStartLevel=4 \
    -Declipse.product=org.eclipse.jdt.ls.core.product \
    -Dlog.protocol=true \
    -Dlog.level=ALL \
    -Xmx1g \
    -javaagent:"$LOMBOK_PATH" \
    -jar "$LAUNCHER_JAR" \
    -configuration "$JDTLS_HOME/config_linux" \
    -data "${1:-$HOME/.cache/jdtls-workspace}" \
    --add-modules=ALL-SYSTEM \
    --add-opens java.base/java.util=ALL-UNNAMED \
    --add-opens java.base/java.lang=ALL-UNNAMED \
    "${@:2}"
