# Spring Boot 整合Gson
- 添加gson依赖
```xml
<!-- pom.xml -->
<dependency>
	<groupId>com.google.code.gson</groupId>
	<artifactId>gson</artifactId>
</dependency>
```
- 排除jaskson依赖
```xml
<!-- pom.xml -->
<dependency>
	<groupId>org.springframework.boot</groupId>
	<artifactId>spring-boot-starter-web</artifactId>
	<exclusions>
		<exclusion>
			<artifactId>jackson-databind</artifactId>
			<groupId>com.fasterxml.jackson.core</groupId>
		</exclusion>
	</exclusions>
</dependency>
```
```kotlin
//SpringBoot启动类
@SpringBootApplication(exclude = [JacksonAutoConfiguration::class])
class MySprintBootApplication
```
```kotlin
@SpringBootConfiguration
class MySpringMvcConfig @Autowired
constructor(private val gson: Gson) : WebMvcConfigurer {


    override fun configureMessageConverters(converters: MutableList<HttpMessageConverter<*>>) {

        //删除MappingJackson2HttpMessageConverter
        //converters.removeIf(httpMessageConverter -> httpMessageConverter instanceof MappingJackson2HttpMessageConverter);

        val gsonHttpMessageConverter = GsonHttpMessageConverter(gson)
        converters.add(gsonHttpMessageConverter)
    }

    //跨域配置
    override fun addCorsMappings(registry: CorsRegistry) {
        registry.addMapping("/**")
                .allowedOrigins("*")
                .allowedMethods("POST", "GET")
                .allowedHeaders("*")
                .allowCredentials(true)
    }
}
```

- 注入Gson
```kotlin
@Configuration
class GsonConfig @Autowired
constructor(private val gsonBuilder: GsonBuilder) {

    @Bean
    fun gson(): Gson {
        return gsonBuilder
                .registerTypeAdapter(Date::class.java, DateSerializer())
                .registerTypeAdapter(Date::class.java, DateDeserializer())
                //自定义排除规则
                .setExclusionStrategies(object : ExclusionStrategy {
                    override fun shouldSkipField(f: FieldAttributes): Boolean {
                        return false
                    }

                    override fun shouldSkipClass(clazz: Class<*>): Boolean {
                        return false
                    }
                })
                .create()
    }


    //日期的序列化和反序列化规则

    internal class DateSerializer : JsonSerializer<Date> {
        override fun serialize(src: Date, typeOfSrc: Type, context: JsonSerializationContext): JsonElement {
            return JsonPrimitive(src.time)
        }
    }

    internal class DateDeserializer : JsonDeserializer<Date> {
        @Throws(JsonParseException::class)
        override fun deserialize(json: JsonElement, typeOfT: Type, context: JsonDeserializationContext): Date {
            val asLong = json.asLong
            return Timestamp(asLong)
        }
    }
}
```