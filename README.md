# karateDSL-course

mvn test -Dkarate.options="--tags @signuprandom" -Dkarate.env="qa"

mvn archetype:generate \
-DarchetypeGroupId=com.intuit.karate \
-DarchetypeArtifactId=karate-archetype \
-DarchetypeVersion=1.1.0 \
-DgroupId=com.buhobyte \
-DartifactId=KarateCourse