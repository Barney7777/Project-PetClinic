FROM openjdk:17-oracle

WORKDIR /home/petclinic/

COPY ./target/spring-petclinic-3.3.0-SNAPSHOT.jar .

EXPOSE 8080

CMD ["java", "-jar", "spring-petclinic-3.3.0-SNAPSHOT.jar"]