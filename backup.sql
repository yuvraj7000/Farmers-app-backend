--
-- PostgreSQL database dump
--

\restrict 9vDLsLVZHi0uULnuc82pZvm2dmUDwuLj390VIA21briQnEARDzvouMHxBeua8aK

-- Dumped from database version 17.7 (Ubuntu 17.7-0ubuntu0.25.04.1)
-- Dumped by pg_dump version 17.7 (Ubuntu 17.7-0ubuntu0.25.04.1)

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: public; Type: SCHEMA; Schema: -; Owner: yuvraj
--

-- *not* creating schema, since initdb creates it


ALTER SCHEMA public OWNER TO yuvraj;

--
-- Name: update_updated_at_column(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.update_updated_at_column() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    NEW.updated_at = CURRENT_TIMESTAMP;
    RETURN NEW;
END;
$$;


ALTER FUNCTION public.update_updated_at_column() OWNER TO postgres;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: crop_paragraphs; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.crop_paragraphs (
    id integer NOT NULL,
    crop_id integer,
    language_code text NOT NULL,
    paragraph_title text NOT NULL,
    paragraph_content text NOT NULL
);


ALTER TABLE public.crop_paragraphs OWNER TO postgres;

--
-- Name: crop_paragraphs_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.crop_paragraphs_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.crop_paragraphs_id_seq OWNER TO postgres;

--
-- Name: crop_paragraphs_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.crop_paragraphs_id_seq OWNED BY public.crop_paragraphs.id;


--
-- Name: crops; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.crops (
    id integer NOT NULL,
    name text NOT NULL,
    image_url text,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.crops OWNER TO postgres;

--
-- Name: crops_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.crops_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.crops_id_seq OWNER TO postgres;

--
-- Name: crops_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.crops_id_seq OWNED BY public.crops.id;


--
-- Name: news; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.news (
    id integer NOT NULL,
    date date DEFAULT CURRENT_DATE NOT NULL,
    image_url text,
    source text,
    language_code text NOT NULL,
    title text,
    content text,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    youtube_url text
);


ALTER TABLE public.news OWNER TO postgres;

--
-- Name: news_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.news_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.news_id_seq OWNER TO postgres;

--
-- Name: news_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.news_id_seq OWNED BY public.news.id;


--
-- Name: scheme_translations; Type: TABLE; Schema: public; Owner: yuvraj
--

CREATE TABLE public.scheme_translations (
    id integer NOT NULL,
    scheme_id integer,
    language_code text NOT NULL,
    name text NOT NULL,
    description text NOT NULL,
    benefits jsonb,
    eligibility jsonb,
    application_process jsonb
);


ALTER TABLE public.scheme_translations OWNER TO yuvraj;

--
-- Name: scheme_translations_id_seq; Type: SEQUENCE; Schema: public; Owner: yuvraj
--

CREATE SEQUENCE public.scheme_translations_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.scheme_translations_id_seq OWNER TO yuvraj;

--
-- Name: scheme_translations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: yuvraj
--

ALTER SEQUENCE public.scheme_translations_id_seq OWNED BY public.scheme_translations.id;


--
-- Name: schemes_subsidies; Type: TABLE; Schema: public; Owner: yuvraj
--

CREATE TABLE public.schemes_subsidies (
    id integer NOT NULL,
    type text NOT NULL,
    gov_level text,
    state_or_org text,
    start_date date,
    end_date date,
    status text NOT NULL,
    official_link text,
    funding_amount numeric(10,2) DEFAULT NULL::numeric,
    image_url text,
    CONSTRAINT schemes_subsidies_gov_level_check CHECK ((gov_level = ANY (ARRAY['State'::text, 'Central'::text, 'Org'::text]))),
    CONSTRAINT schemes_subsidies_status_check CHECK ((status = ANY (ARRAY['ACTIVE'::text, 'EXPIRED'::text, 'UPCOMING'::text]))),
    CONSTRAINT schemes_subsidies_type_check CHECK ((type = ANY (ARRAY['Government'::text, 'Private'::text])))
);


ALTER TABLE public.schemes_subsidies OWNER TO yuvraj;

--
-- Name: schemes_subsidies_id_seq; Type: SEQUENCE; Schema: public; Owner: yuvraj
--

CREATE SEQUENCE public.schemes_subsidies_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.schemes_subsidies_id_seq OWNER TO yuvraj;

--
-- Name: schemes_subsidies_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: yuvraj
--

ALTER SEQUENCE public.schemes_subsidies_id_seq OWNED BY public.schemes_subsidies.id;


--
-- Name: user_fcm_tokens; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.user_fcm_tokens (
    id integer NOT NULL,
    fcm_token text NOT NULL,
    district character varying(255) DEFAULT NULL::character varying,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    language character varying(50) DEFAULT 'en'::character varying NOT NULL
);


ALTER TABLE public.user_fcm_tokens OWNER TO postgres;

--
-- Name: user_fcm_tokens_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.user_fcm_tokens_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.user_fcm_tokens_id_seq OWNER TO postgres;

--
-- Name: user_fcm_tokens_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.user_fcm_tokens_id_seq OWNED BY public.user_fcm_tokens.id;


--
-- Name: crop_paragraphs id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.crop_paragraphs ALTER COLUMN id SET DEFAULT nextval('public.crop_paragraphs_id_seq'::regclass);


--
-- Name: crops id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.crops ALTER COLUMN id SET DEFAULT nextval('public.crops_id_seq'::regclass);


--
-- Name: news id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.news ALTER COLUMN id SET DEFAULT nextval('public.news_id_seq'::regclass);


--
-- Name: scheme_translations id; Type: DEFAULT; Schema: public; Owner: yuvraj
--

ALTER TABLE ONLY public.scheme_translations ALTER COLUMN id SET DEFAULT nextval('public.scheme_translations_id_seq'::regclass);


--
-- Name: schemes_subsidies id; Type: DEFAULT; Schema: public; Owner: yuvraj
--

ALTER TABLE ONLY public.schemes_subsidies ALTER COLUMN id SET DEFAULT nextval('public.schemes_subsidies_id_seq'::regclass);


--
-- Name: user_fcm_tokens id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_fcm_tokens ALTER COLUMN id SET DEFAULT nextval('public.user_fcm_tokens_id_seq'::regclass);


--
-- Data for Name: crop_paragraphs; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.crop_paragraphs (id, crop_id, language_code, paragraph_title, paragraph_content) FROM stdin;
64	16	hi	परिचय	कपास दुनिया की सबसे महत्वपूर्ण प्राकृतिक रेशा फसलों में से एक है और वैश्विक वस्त्र उद्योग में इसकी महत्वपूर्ण भूमिका है। यह एक मुलायम और हल्का रेशा है जो कपास के पौधे के बीजों के आसपास उगता है। कपास से कपड़े, वस्त्र, घरेलू उपयोग के कपड़े और कई औद्योगिक उत्पाद बनाए जाते हैं। इसकी मुलायमता, सांस लेने योग्य गुण और आरामदायक प्रकृति के कारण कपास हजारों वर्षों से सबसे लोकप्रिय वस्त्र सामग्री रही है।
65	16	hi	उत्पत्ति और इतिहास	कपास की खेती लगभग 7000 वर्ष पहले भारत, मिस्र और दक्षिण अमेरिका जैसे क्षेत्रों में की जाती थी। पुरातात्विक साक्ष्य बताते हैं कि सिंधु घाटी सभ्यता में कपास के वस्त्रों का उपयोग किया जाता था। समय के साथ कपास की खेती दुनिया के कई हिस्सों में फैल गई, विशेष रूप से औद्योगिक क्रांति के दौरान जब वस्त्र उद्योग तेजी से विकसित हुआ। आज कपास दुनिया की सबसे अधिक उगाई और व्यापार की जाने वाली कृषि फसलों में से एक है।
66	16	hi	वनस्पति विवरण	कपास का पौधा मालवेसी (Malvaceae) परिवार और गोसिपियम (Gossypium) वंश से संबंधित है। यह एक झाड़ीदार पौधा होता है जिसकी ऊंचाई सामान्यतः 1 से 2 मीटर तक होती है। इसमें पीले या सफेद रंग के फूल आते हैं जो बाद में कपास के बॉल (boll) में बदल जाते हैं। इन बॉल के अंदर बीज होते हैं जिनके चारों ओर सफेद रेशे होते हैं। जब बॉल पक जाती है तो वह फट जाती है और कपास के रेशे बाहर दिखाई देने लगते हैं।
67	16	hi	जलवायु और मिट्टी की आवश्यकता	कपास की खेती गर्म जलवायु में सबसे अच्छी होती है जहां पर्याप्त धूप और मध्यम वर्षा होती है। इसके लिए आदर्श तापमान 21°C से 30°C के बीच माना जाता है। कपास की फसल को लंबी अवधि तक पाला-मुक्त मौसम की आवश्यकता होती है। यह अच्छी जल निकासी वाली उपजाऊ मिट्टी जैसे काली मिट्टी, जलोढ़ मिट्टी और बलुई दोमट मिट्टी में अच्छी तरह उगती है।
68	16	hi	विश्व के प्रमुख कपास उत्पादक देश	कपास दुनिया के 80 से अधिक देशों में उगाई जाती है। प्रमुख कपास उत्पादक देशों में भारत, चीन, संयुक्त राज्य अमेरिका, ब्राज़ील और पाकिस्तान शामिल हैं। वर्तमान में भारत विश्व का सबसे बड़ा कपास उत्पादक देश है। इन देशों से कपास की आपूर्ति दुनिया भर के वस्त्र उद्योगों को की जाती है।
69	16	hi	भारत में कपास उत्पादन	भारत कपास के उत्पादन और निर्यात में अग्रणी देशों में से एक है। भारत के प्रमुख कपास उत्पादक राज्यों में गुजरात, महाराष्ट्र, तेलंगाना, आंध्र प्रदेश, पंजाब, हरियाणा, राजस्थान और मध्य प्रदेश शामिल हैं। कपास भारतीय कृषि अर्थव्यवस्था में महत्वपूर्ण भूमिका निभाती है और लाखों किसानों तथा श्रमिकों को रोजगार प्रदान करती है।
70	16	hi	कपास के प्रकार	कपास के कई प्रकार होते हैं जो मुख्य रूप से रेशे की लंबाई और गुणवत्ता के आधार पर वर्गीकृत किए जाते हैं। प्रमुख प्रकारों में शॉर्ट स्टेपल, मीडियम स्टेपल और लॉन्ग स्टेपल कपास शामिल हैं। लॉन्ग स्टेपल कपास से बेहतर गुणवत्ता का धागा बनता है और इसका उपयोग उच्च गुणवत्ता वाले वस्त्र बनाने में किया जाता है। मिस्री कपास और पिमा कपास इसके प्रसिद्ध उदाहरण हैं।
83	16	en	Types of Cotton	There are several types of cotton grown worldwide based on fiber length and quality. The main types include short-staple cotton, medium-staple cotton, and long-staple cotton. Long-staple cotton produces finer and stronger yarn and is commonly used for high-quality textiles. Egyptian cotton and Pima cotton are well-known examples of premium long-staple cotton varieties.
71	16	hi	कपास की खेती की प्रक्रिया	कपास की खेती में भूमि की तैयारी, बीज बोना, सिंचाई, उर्वरक का उपयोग, कीट नियंत्रण, कटाई और प्रसंस्करण जैसी कई प्रक्रियाएं शामिल होती हैं। किसान आमतौर पर गर्म मौसम में बीज बोते हैं। फसल को नियमित सिंचाई और कीटों से सुरक्षा की आवश्यकता होती है। जब कपास के बॉल पक जाते हैं और फट जाते हैं, तब उनकी कटाई की जाती है।
72	16	hi	कटाई और प्रसंस्करण	कपास की कटाई तब की जाती है जब बॉल पूरी तरह पक कर खुल जाती है। कई देशों में कपास की कटाई हाथों से की जाती है ताकि गुणवत्ता बनी रहे। कटाई के बाद कपास को जिनिंग प्रक्रिया से गुजारा जाता है जिसमें रेशों को बीज से अलग किया जाता है। इसके बाद रेशों को गांठों में दबाकर वस्त्र मिलों में भेजा जाता है।
73	16	hi	कपास के उपयोग	कपास का उपयोग वस्त्र उद्योग में व्यापक रूप से किया जाता है। इससे शर्ट, पैंट, साड़ी, बिस्तर की चादरें और अन्य कपड़े बनाए जाते हैं। इसके अलावा कपास का उपयोग चिकित्सा सामग्री, घरेलू उत्पादों और औद्योगिक उत्पादों में भी किया जाता है। कपास के बीज से कपास का तेल और पशुओं के लिए चारा भी तैयार किया जाता है।
74	16	hi	आर्थिक महत्व	कपास को अक्सर 'सफेद सोना' कहा जाता है क्योंकि इसका आर्थिक महत्व बहुत अधिक है। यह लाखों किसानों, मजदूरों और उद्योगों को रोजगार प्रदान करती है। कपास उत्पादन ग्रामीण अर्थव्यवस्था को मजबूत बनाने और निर्यात आय बढ़ाने में महत्वपूर्ण योगदान देता है।
75	16	hi	कपास खेती की चुनौतियां	कपास की खेती कई चुनौतियों का सामना करती है जैसे कीट प्रकोप, जलवायु परिवर्तन, पानी की कमी और बाजार मूल्य में उतार-चढ़ाव। कपास की फसल पर विशेष रूप से बॉलवर्म जैसे कीटों का खतरा रहता है। अनिश्चित मौसम और वर्षा की कमी भी उत्पादन को प्रभावित कर सकती है।
76	16	hi	कपास खेती का भविष्य	कपास खेती का भविष्य टिकाऊ कृषि पद्धतियों, बेहतर बीज किस्मों और आधुनिक तकनीकों पर निर्भर करता है। ड्रिप सिंचाई, उन्नत बीज, और एकीकृत कीट प्रबंधन जैसी तकनीकें किसानों को उत्पादन बढ़ाने और पर्यावरणीय प्रभाव कम करने में मदद कर रही हैं। टिकाऊ कपास उत्पादन किसानों की आय और पर्यावरण संरक्षण दोनों के लिए महत्वपूर्ण है।
77	16	en	Introduction	Cotton is one of the most important natural fiber crops in the world and plays a crucial role in the global textile industry. It is a soft, fluffy staple fiber that grows around the seeds of cotton plants belonging to the genus Gossypium. Cotton is widely used for making fabrics, clothing, home textiles, and many industrial products. Due to its softness, breathability, and comfort, cotton has been a preferred fabric for thousands of years.
78	16	en	Origin and History	Cotton has been cultivated for more than 7,000 years in regions such as India, Egypt, and South America. Archaeological evidence shows that cotton fabrics were used in the Indus Valley Civilization. Over time, cotton cultivation spread across the world, especially during the industrial revolution when textile manufacturing expanded rapidly. Today, cotton remains one of the most widely grown and traded agricultural commodities.
79	16	en	Botanical Description	Cotton plants belong to the Malvaceae family and the genus Gossypium. The plant is a shrub that grows between 1 to 2 meters tall depending on the variety. It produces large yellow or white flowers that later develop into cotton bolls. Inside these bolls are seeds surrounded by white cotton fibers. When the boll matures and bursts open, the cotton fibers become visible and ready for harvesting.
80	16	en	Climate and Soil Requirements	Cotton grows best in warm climates with plenty of sunshine and moderate rainfall. The ideal temperature range for cotton cultivation is between 21°C and 30°C. The crop requires a long frost-free period for proper growth and development. Cotton prefers well-drained fertile soils such as black cotton soil, alluvial soil, or sandy loam soil with good moisture retention capacity.
81	16	en	Major Cotton Producing Countries	Cotton is grown in more than 80 countries around the world. The largest cotton-producing countries include India, China, the United States, Brazil, and Pakistan. India is currently the largest producer of cotton globally and has a large number of farmers involved in cotton cultivation. These countries supply cotton to textile industries across the world.
82	16	en	Cotton Production in India	India is one of the leading producers and exporters of cotton in the world. Major cotton-growing states in India include Gujarat, Maharashtra, Telangana, Andhra Pradesh, Punjab, Haryana, Rajasthan, and Madhya Pradesh. Cotton plays a vital role in the Indian agricultural economy and provides livelihood to millions of farmers and workers involved in farming, ginning, spinning, and textile production.
84	16	en	Cotton Cultivation Process	Cotton cultivation involves several stages including land preparation, sowing, irrigation, fertilization, pest control, harvesting, and processing. Farmers usually sow cotton seeds during the warm season after preparing the soil. The crop requires regular watering and protection from pests such as bollworms. Once the cotton bolls mature and open, farmers harvest the cotton either manually or with machines.
85	16	en	Harvesting and Processing	Cotton harvesting typically begins when the cotton bolls fully mature and burst open. In many developing countries, cotton is harvested manually by hand to ensure quality. After harvesting, the cotton undergoes a process called ginning where the fibers are separated from the seeds. The cleaned fibers are then compressed into bales and transported to textile mills for spinning and fabric production.
86	16	en	Uses of Cotton	Cotton is widely used in the textile industry for making clothes such as shirts, trousers, sarees, and bedsheets. It is also used in home furnishings, medical supplies, and industrial products. Cottonseed, a byproduct of cotton farming, is used to produce cottonseed oil for cooking and cottonseed cake for animal feed. Cotton fibers are also used in making bandages, surgical products, and paper.
87	16	en	Economic Importance	Cotton is often called 'White Gold' because of its immense economic value. It supports millions of farmers, workers, and businesses in agriculture and textile industries. Cotton production contributes significantly to rural employment, export earnings, and industrial growth in many countries. The textile sector, which heavily depends on cotton, is one of the largest employment generators worldwide.
88	16	en	Challenges in Cotton Farming	Despite its importance, cotton farming faces several challenges including pest infestations, climate change, water scarcity, and fluctuating market prices. Cotton crops are particularly vulnerable to pests like bollworms and aphids. Farmers also face risks from unpredictable rainfall and extreme weather conditions, which can affect crop yields and quality.
89	16	en	Future of Cotton Farming	The future of cotton farming depends on sustainable agricultural practices, improved seed varieties, and modern farming technologies. Innovations such as genetically improved cotton seeds, precision farming, drip irrigation, and integrated pest management are helping farmers increase productivity and reduce environmental impact. Sustainable cotton production is becoming increasingly important for protecting ecosystems and supporting farmer livelihoods.
90	17	hi	परिचय	कपास दुनिया की सबसे महत्वपूर्ण प्राकृतिक रेशा फसलों में से एक है और वैश्विक वस्त्र उद्योग में इसकी महत्वपूर्ण भूमिका है। यह एक मुलायम और हल्का रेशा है जो कपास के पौधे के बीजों के आसपास उगता है। कपास से कपड़े, वस्त्र, घरेलू उपयोग के कपड़े और कई औद्योगिक उत्पाद बनाए जाते हैं। इसकी मुलायमता, सांस लेने योग्य गुण और आरामदायक प्रकृति के कारण कपास हजारों वर्षों से सबसे लोकप्रिय वस्त्र सामग्री रही है।
91	17	hi	उत्पत्ति और इतिहास	कपास की खेती लगभग 7000 वर्ष पहले भारत, मिस्र और दक्षिण अमेरिका जैसे क्षेत्रों में की जाती थी। पुरातात्विक साक्ष्य बताते हैं कि सिंधु घाटी सभ्यता में कपास के वस्त्रों का उपयोग किया जाता था। समय के साथ कपास की खेती दुनिया के कई हिस्सों में फैल गई, विशेष रूप से औद्योगिक क्रांति के दौरान जब वस्त्र उद्योग तेजी से विकसित हुआ। आज कपास दुनिया की सबसे अधिक उगाई और व्यापार की जाने वाली कृषि फसलों में से एक है।
92	17	hi	वनस्पति विवरण	कपास का पौधा मालवेसी (Malvaceae) परिवार और गोसिपियम (Gossypium) वंश से संबंधित है। यह एक झाड़ीदार पौधा होता है जिसकी ऊंचाई सामान्यतः 1 से 2 मीटर तक होती है। इसमें पीले या सफेद रंग के फूल आते हैं जो बाद में कपास के बॉल (boll) में बदल जाते हैं। इन बॉल के अंदर बीज होते हैं जिनके चारों ओर सफेद रेशे होते हैं। जब बॉल पक जाती है तो वह फट जाती है और कपास के रेशे बाहर दिखाई देने लगते हैं।
93	17	hi	जलवायु और मिट्टी की आवश्यकता	कपास की खेती गर्म जलवायु में सबसे अच्छी होती है जहां पर्याप्त धूप और मध्यम वर्षा होती है। इसके लिए आदर्श तापमान 21°C से 30°C के बीच माना जाता है। कपास की फसल को लंबी अवधि तक पाला-मुक्त मौसम की आवश्यकता होती है। यह अच्छी जल निकासी वाली उपजाऊ मिट्टी जैसे काली मिट्टी, जलोढ़ मिट्टी और बलुई दोमट मिट्टी में अच्छी तरह उगती है।
94	17	hi	विश्व के प्रमुख कपास उत्पादक देश	कपास दुनिया के 80 से अधिक देशों में उगाई जाती है। प्रमुख कपास उत्पादक देशों में भारत, चीन, संयुक्त राज्य अमेरिका, ब्राज़ील और पाकिस्तान शामिल हैं। वर्तमान में भारत विश्व का सबसे बड़ा कपास उत्पादक देश है। इन देशों से कपास की आपूर्ति दुनिया भर के वस्त्र उद्योगों को की जाती है।
95	17	hi	भारत में कपास उत्पादन	भारत कपास के उत्पादन और निर्यात में अग्रणी देशों में से एक है। भारत के प्रमुख कपास उत्पादक राज्यों में गुजरात, महाराष्ट्र, तेलंगाना, आंध्र प्रदेश, पंजाब, हरियाणा, राजस्थान और मध्य प्रदेश शामिल हैं। कपास भारतीय कृषि अर्थव्यवस्था में महत्वपूर्ण भूमिका निभाती है और लाखों किसानों तथा श्रमिकों को रोजगार प्रदान करती है।
96	17	hi	कपास के प्रकार	कपास के कई प्रकार होते हैं जो मुख्य रूप से रेशे की लंबाई और गुणवत्ता के आधार पर वर्गीकृत किए जाते हैं। प्रमुख प्रकारों में शॉर्ट स्टेपल, मीडियम स्टेपल और लॉन्ग स्टेपल कपास शामिल हैं। लॉन्ग स्टेपल कपास से बेहतर गुणवत्ता का धागा बनता है और इसका उपयोग उच्च गुणवत्ता वाले वस्त्र बनाने में किया जाता है। मिस्री कपास और पिमा कपास इसके प्रसिद्ध उदाहरण हैं।
97	17	hi	कपास की खेती की प्रक्रिया	कपास की खेती में भूमि की तैयारी, बीज बोना, सिंचाई, उर्वरक का उपयोग, कीट नियंत्रण, कटाई और प्रसंस्करण जैसी कई प्रक्रियाएं शामिल होती हैं। किसान आमतौर पर गर्म मौसम में बीज बोते हैं। फसल को नियमित सिंचाई और कीटों से सुरक्षा की आवश्यकता होती है। जब कपास के बॉल पक जाते हैं और फट जाते हैं, तब उनकी कटाई की जाती है।
98	17	hi	कटाई और प्रसंस्करण	कपास की कटाई तब की जाती है जब बॉल पूरी तरह पक कर खुल जाती है। कई देशों में कपास की कटाई हाथों से की जाती है ताकि गुणवत्ता बनी रहे। कटाई के बाद कपास को जिनिंग प्रक्रिया से गुजारा जाता है जिसमें रेशों को बीज से अलग किया जाता है। इसके बाद रेशों को गांठों में दबाकर वस्त्र मिलों में भेजा जाता है।
99	17	hi	कपास के उपयोग	कपास का उपयोग वस्त्र उद्योग में व्यापक रूप से किया जाता है। इससे शर्ट, पैंट, साड़ी, बिस्तर की चादरें और अन्य कपड़े बनाए जाते हैं। इसके अलावा कपास का उपयोग चिकित्सा सामग्री, घरेलू उत्पादों और औद्योगिक उत्पादों में भी किया जाता है। कपास के बीज से कपास का तेल और पशुओं के लिए चारा भी तैयार किया जाता है।
100	17	hi	आर्थिक महत्व	कपास को अक्सर 'सफेद सोना' कहा जाता है क्योंकि इसका आर्थिक महत्व बहुत अधिक है। यह लाखों किसानों, मजदूरों और उद्योगों को रोजगार प्रदान करती है। कपास उत्पादन ग्रामीण अर्थव्यवस्था को मजबूत बनाने और निर्यात आय बढ़ाने में महत्वपूर्ण योगदान देता है।
101	17	hi	कपास खेती की चुनौतियां	कपास की खेती कई चुनौतियों का सामना करती है जैसे कीट प्रकोप, जलवायु परिवर्तन, पानी की कमी और बाजार मूल्य में उतार-चढ़ाव। कपास की फसल पर विशेष रूप से बॉलवर्म जैसे कीटों का खतरा रहता है। अनिश्चित मौसम और वर्षा की कमी भी उत्पादन को प्रभावित कर सकती है।
102	17	hi	कपास खेती का भविष्य	कपास खेती का भविष्य टिकाऊ कृषि पद्धतियों, बेहतर बीज किस्मों और आधुनिक तकनीकों पर निर्भर करता है। ड्रिप सिंचाई, उन्नत बीज, और एकीकृत कीट प्रबंधन जैसी तकनीकें किसानों को उत्पादन बढ़ाने और पर्यावरणीय प्रभाव कम करने में मदद कर रही हैं। टिकाऊ कपास उत्पादन किसानों की आय और पर्यावरण संरक्षण दोनों के लिए महत्वपूर्ण है।
103	17	en	Introduction	Cotton is one of the most important natural fiber crops in the world and plays a crucial role in the global textile industry. It is a soft, fluffy staple fiber that grows around the seeds of cotton plants belonging to the genus Gossypium. Cotton is widely used for making fabrics, clothing, home textiles, and many industrial products. Due to its softness, breathability, and comfort, cotton has been a preferred fabric for thousands of years.
104	17	en	Origin and History	Cotton has been cultivated for more than 7,000 years in regions such as India, Egypt, and South America. Archaeological evidence shows that cotton fabrics were used in the Indus Valley Civilization. Over time, cotton cultivation spread across the world, especially during the industrial revolution when textile manufacturing expanded rapidly. Today, cotton remains one of the most widely grown and traded agricultural commodities.
105	17	en	Botanical Description	Cotton plants belong to the Malvaceae family and the genus Gossypium. The plant is a shrub that grows between 1 to 2 meters tall depending on the variety. It produces large yellow or white flowers that later develop into cotton bolls. Inside these bolls are seeds surrounded by white cotton fibers. When the boll matures and bursts open, the cotton fibers become visible and ready for harvesting.
106	17	en	Climate and Soil Requirements	Cotton grows best in warm climates with plenty of sunshine and moderate rainfall. The ideal temperature range for cotton cultivation is between 21°C and 30°C. The crop requires a long frost-free period for proper growth and development. Cotton prefers well-drained fertile soils such as black cotton soil, alluvial soil, or sandy loam soil with good moisture retention capacity.
107	17	en	Major Cotton Producing Countries	Cotton is grown in more than 80 countries around the world. The largest cotton-producing countries include India, China, the United States, Brazil, and Pakistan. India is currently the largest producer of cotton globally and has a large number of farmers involved in cotton cultivation. These countries supply cotton to textile industries across the world.
108	17	en	Cotton Production in India	India is one of the leading producers and exporters of cotton in the world. Major cotton-growing states in India include Gujarat, Maharashtra, Telangana, Andhra Pradesh, Punjab, Haryana, Rajasthan, and Madhya Pradesh. Cotton plays a vital role in the Indian agricultural economy and provides livelihood to millions of farmers and workers involved in farming, ginning, spinning, and textile production.
109	17	en	Types of Cotton	There are several types of cotton grown worldwide based on fiber length and quality. The main types include short-staple cotton, medium-staple cotton, and long-staple cotton. Long-staple cotton produces finer and stronger yarn and is commonly used for high-quality textiles. Egyptian cotton and Pima cotton are well-known examples of premium long-staple cotton varieties.
110	17	en	Cotton Cultivation Process	Cotton cultivation involves several stages including land preparation, sowing, irrigation, fertilization, pest control, harvesting, and processing. Farmers usually sow cotton seeds during the warm season after preparing the soil. The crop requires regular watering and protection from pests such as bollworms. Once the cotton bolls mature and open, farmers harvest the cotton either manually or with machines.
111	17	en	Harvesting and Processing	Cotton harvesting typically begins when the cotton bolls fully mature and burst open. In many developing countries, cotton is harvested manually by hand to ensure quality. After harvesting, the cotton undergoes a process called ginning where the fibers are separated from the seeds. The cleaned fibers are then compressed into bales and transported to textile mills for spinning and fabric production.
112	17	en	Uses of Cotton	Cotton is widely used in the textile industry for making clothes such as shirts, trousers, sarees, and bedsheets. It is also used in home furnishings, medical supplies, and industrial products. Cottonseed, a byproduct of cotton farming, is used to produce cottonseed oil for cooking and cottonseed cake for animal feed. Cotton fibers are also used in making bandages, surgical products, and paper.
113	17	en	Economic Importance	Cotton is often called 'White Gold' because of its immense economic value. It supports millions of farmers, workers, and businesses in agriculture and textile industries. Cotton production contributes significantly to rural employment, export earnings, and industrial growth in many countries. The textile sector, which heavily depends on cotton, is one of the largest employment generators worldwide.
114	17	en	Challenges in Cotton Farming	Despite its importance, cotton farming faces several challenges including pest infestations, climate change, water scarcity, and fluctuating market prices. Cotton crops are particularly vulnerable to pests like bollworms and aphids. Farmers also face risks from unpredictable rainfall and extreme weather conditions, which can affect crop yields and quality.
115	17	en	Future of Cotton Farming	The future of cotton farming depends on sustainable agricultural practices, improved seed varieties, and modern farming technologies. Innovations such as genetically improved cotton seeds, precision farming, drip irrigation, and integrated pest management are helping farmers increase productivity and reduce environmental impact. Sustainable cotton production is becoming increasingly important for protecting ecosystems and supporting farmer livelihoods.
\.


--
-- Data for Name: crops; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.crops (id, name, image_url, created_at) FROM stdin;
16	Cotton	https://www.saatva.com/blog/wp-content/uploads/2023/01/15666ab2-5580-4151-a4fe-4d3eba64aaaf_difference-between-organic-cotton-vs-cotton-4.jpg	2026-04-01 20:43:56.213369
17	cotton	https://www.saatva.com/blog/wp-content/uploads/2023/01/15666ab2-5580-4151-a4fe-4d3eba64aaaf_difference-between-organic-cotton-vs-cotton-4.jpg	2026-04-01 20:44:13.820872
\.


--
-- Data for Name: news; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.news (id, date, image_url, source, language_code, title, content, created_at, updated_at, youtube_url) FROM stdin;
34	2025-06-09	https://res.cloudinary.com/dvxqsgbmo/image/upload/v1749473617/WhatsApp_Image_2025-06-09_at_9.52.23_AM_dsue3c.jpg	\N	hi	इन कंपनियों का खाद न खरीदे	किसान भाई, इन कंपनियों का खाद न खरीदे वरना आपके साथ ठगी हो सकती है।किसानों को यह सख्त सलाह दी जाती है कि वे इन कंपनियों द्वारा बेचे जा रहे खाद (फर्टिलाइजर) से सावधान रहें। ऐसी कंपनियां अक्सर झूठे दावे करती हैं और घटिया गुणवत्ता का माल देती हैं, जिससे फसल खराब हो सकती है। इसके अलावा, ये कंपनियां सही दाम से कई गुना ज्यादा वसूल कर लेती हैं और किसान भाइयों को भारी नुकसान उठाना पड़ता है।हमारी आपसे अपील है कि: ✅ किसी भी खाद या उर्वरक को खरीदने से पहले उसकी प्रमाणिकता जरूर जांचें। ✅ सरकारी या मान्यता प्राप्त एजेंसियों से खाद लें। ✅ संदिग्ध कंपनियों के झांसे में न आएं। ✅ किसी भी दावे या विज्ञापन पर आँख बंद करके भरोसा न करें। ✅ अपने नजदीकी कृषि कार्यालय या कृषि अधिकारी से परामर्श लें। खाद की खरीदारी में सावधानी बरतना ही किसान भाइयों के हित में है।	2025-06-09 12:56:58.967414	2025-06-09 12:56:58.967414	\N
36	2025-06-11	https://www.krishakjagat.org/wp-content/uploads/2025/06/Untitled-1-Recovered-18.webp	\N	hi	मध्य प्रदेश में उपसंचालक, सहायक संचालक कृषि के तबादले	11 जून 2025, भोपाल: मध्य प्रदेश में उपसंचालक, सहायक संचालक कृषि के तबादले – राज्य शासन कृषि विभाग ने 12 उपसंचालक कृषि एवं 48 सहायक संचालक कृषि की पदस्थापना में फेरबदल किया है। इसमें प्रशासनिक एवं स्वयं के व्यय पर किए गए दोनों तबादले शामिल हैं। उल्लेखनीय है कि प्रतिबंध खुलने के बाद सभी विभाग तबादला सूची जारी करने में व्यस्त हैं। मुख्यमंत्री ने स्थानांतरण की तिथि 17 जून तक बढ़ा दी है।	2025-06-11 17:34:48.366489	2025-06-11 17:34:48.366489	\N
43	2026-04-01	https://img.etimg.com/thumb/msid-129948236,width-300,height-225,imgsize-237914,resizemode-75/india-has-enough-seed-stock-available-amid-the-israel-iran-war-says-govt-official.jpg	indiatimes	en	India has adequate seed stock available amid the Israel-Iran war, says govt official	India has adequate seed stock available for the upcoming sowing season, a government official said on Wednesday, as war in the Middle East continues to disrupt global supply chain.\n"India has enough seed stock available for the upcoming sowing season," Additional Secretary, Agriculture and Farmer Welfare, Maninder Kaur Dwivedi said during the government's inter-ministerial briefing on recent developments in West Asia.\nThe country has a self-reliant seed system backed by ICAR and public sector in addition to private sector for production and distribution of seeds. A robust pipeline with adequate seed and breeding materials at all stages (certified, foundation, hybrid seeds) is also present in order to cater to any possible disruptions.\nFertiliser situation stable\nThe government asserted that the country has ample fertiliser as opening stock for the upcoming kharif season. India's fertilizers requirement assessed in consultation with states for Kharif 2026 stands at 390.54 LMT, against which 180 LMT (46%) is available as opening stock.\n\nThe Centre held a meeting of Department of Agriculture & Farmers Welfare, Department of Fisheries and State Secretaries on March 30 for inspecting judicious use of fertilizers, and ensuring timely & orderly last mile delivery.\n\nTo continue strict vigil on diversion of fertilizer for non agricultural use, hoarding etc., the ministry has launched a nationwide enforcement drive in coordination with the states.\n	2026-04-01 20:15:50.665984	2026-04-01 20:15:50.665984	
44	2026-04-01	https://bl-i.thgim.com/public/incoming/syjos1/article70812454.ece/alternates/LANDSCAPE_1200/Fertilizer-stocGOOFNFDQ9.3.jpg.jpg	thehindubusinessline	en	 Agri Business Indian govt to ensure no shortage of agriculture inputs during kharif season	Priority allocation of LPG/PNG has been ensured for maize seed drying through uninterrupted fuel supply; availability of hybrid maize seeds will be ensured.\n\nAmid reported panic sales of fertilisers ahead of the kharif sowing season, which will start with the arrival of monsoon rain, the Indian government on Wednesday said that it would ensure there is no shortage of seeds, fertilisers and agro chemicals.\n\nBriefing the media on the daily inter-ministerial update, Maninder Kaur Dwivedi, additional secretary in the Ministry of Agriculture and Farmers Welfare, said that priority allocation of LPG/PNG has been ensured for seed drying for maize through uninterrupted fuel supply, and there will not be any problem regarding availability of hybrid maize seeds.\n\nSharing an update on the likely impact of developments in West Asia on the agriculture sector, she said there is comfortable seed availability for Kharif 2026, with requirement of 166.46 lakh quintals against availability of 185.74 lakh quintals, resulting in a surplus of around 19.29 lakh quintals.\n\n	2026-04-01 20:18:42.498242	2026-04-01 20:18:42.498242	
45	2026-04-01	https://bl-i.thgim.com/public/economy/agri-business/w3sekd/article70794356.ece/alternates/LANDSCAPE_1200/Cotton-prices-gGP5FP7ULE.4.jpg.jpg	thehindubusinessline	en	Price rebound, El Nino outlook may boost India’s 2026 cotton acreage 	Stakeholders feel the area under cotton could rise by up to 20% amidst projections for deficit rains.\n\nIndia is likely to see an increase in cotton acreage by up to a fifth in the upcoming 2026 kharif season, supported by a rebound in domestic prices, improving global demand for the fibre crop and expectations of a deficit monsoon due to a possible El Nino, stakeholders said. This is even as key producers such as the US and Australia are likely to see reduced area on rising cultivation costs and unfavourable returns.\n\nPlacement of cotton seeds in the North Zone in states such as Punjab, Haryana and Rajasthan has begun, where the seeding is expected to start in a couple of weeks.\n\n“Next year cotton sowing is likely to increase by 20 per cent,” said Atul S Ganatra, former president, Cotton Association of India (CAI).\n\n	2026-04-01 20:24:05.798931	2026-04-01 20:24:05.798931	
46	2026-04-01	https://kjhindi.gumlet.io/media/93806/shivraj-singh-chouhan.jpg?w=700&dpr=1.3	krishijagran	hi	किसानों की आय वृद्धि, तकनीक और नवाचार पर केंद्रित कृषि जोनल कॉन्फ्रेंसों की श्रृंखला 7 अप्रैल से होगी शुरू	केंद्र सरकार ने कृषि क्षेत्र को मजबूत बनाने के लिए अप्रैल-मई 2026 में देशभर में जोनल कॉन्फ्रेंस की श्रृंखला शुरू करने का फैसला किया है। इन बैठकों में मंत्री, वैज्ञानिक, किसान व स्टार्टअप मिलकर योजनाओं की समीक्षा कर भविष्य की रणनीति तय करेंगे।\nकेंद्र–राज्य साझेदारी से कृषि में नए युग की हो रही है शुरुआत: जयपुर से गूंजेगा बदलाव का संकल्प\nकृषि नीति, विज्ञान और फील्ड अनुभव को एक मंच पर लाने की केंद्रीय कृषि मंत्री  शिवराज सिंह चौहान द्वारा ऐतिहासिक पहल\nकिसानों की आय वृद्धि, तकनीक और नवाचार पर केंद्रित कृषि जोनल कॉन्फ्रेंसों की श्रृंखला 7 अप्रैल से होगी शुरू-  शिवराज सिंह\nजयपुर, लखनऊ, भुवनेश्वर के बाद मई में हैदराबाद और गुवाहाटी में भी होगा जोनल सम्मेलन-  शिवराज सिंह\nभारत सरकार के कृषि एवं किसान कल्याण मंत्रालय द्वारा प्रधानमंत्री नरेंद्र मोदी के मार्गदर्शन में और केंद्रीय मंत्री शिवराज सिंह चौहान की पहल पर पूरे देश में क्षेत्रवार जोनल कॉन्फ्रेंस की व्यापक श्रृंखला शुरू की जा रही है, जिसके तहत अप्रैल–मई 2026 में पश्चिम, उत्तर, पूर्व सहित सभी प्रमुख जोन में उच्चस्तरीय विचार-विमर्श होगा। इन सम्मेलनों में केंद्र और राज्यों के कृषि मंत्री, वरिष्ठ अधिकारी, वैज्ञानिक, प्रगतिशील किसान, किसान संगठन, एफपीओ, स्टार्टअप और निजी क्षेत्र एक साथ बैठकर योजनाओं की प्रगति की समीक्षा करेंगे और जमीन से जुड़े अनुभवों के आधार पर आगे की कार्ययोजना तय करेंगे।\n\nकेंद्रीय कृषि मंत्री शिवराज सिंह चौहान ने आज यह जानकारी देते हुए बताया कि पश्चिमी क्षेत्र का पहला जोनल सम्मेलन 7 अप्रैल 2026 को जयपुर में आयोजित किया जा रहा है, जिसमें राजस्थान, मध्य प्रदेश, महाराष्ट्र, गुजरात और गोवा के प्रतिनिधि भाग लेंगे। इसमें राजस्थान के मुख्यमंत्री  भजनलाल शर्मा सहित संबद्ध राज्यों के कृषि मंत्री और सभी वरिष्ठ कृषि अधिकारी शामिल होंगे।\n\nकृषि मंत्री  शिवराज सिंह ने बताया कि इसके बाद 17 अप्रैल को लखनऊ में उत्तर भारत के राज्यों और केंद्रशासित प्रदेशों– दिल्ली, चंडीगढ़, जम्मू‑कश्मीर, उत्तर प्रदेश, हरियाणा, हिमाचल प्रदेश, लद्दाख, पंजाब और उत्तराखंड के लिए जोनल कॉन्फ्रेंस आयोजित होगी।\n\nशिवराज सिंह के मुताबिक, 24 अप्रैल को भुवनेश्वर में पूर्वी जोन के लिए सम्मेलन प्रस्तावित है, जिसमें बिहार, झारखंड, ओडिशा, पश्चिम बंगाल आदि राज्यों के प्रतिनिधि शामिल होंगे। श्रृंखला की निरंतरता में मई माह के अंत में हैदराबाद और गुवाहाटी में भी जोनल कॉन्फ्रेंस आयोजित की जाएगी ताकि दक्षिण और उत्तर‑पूर्वी क्षेत्र की विशेष चुनौतियों और संभावनाओं पर केंद्रित चर्चा हो सके।\n\nउद्देश्य : योजनाओं की गति, किसानों की समृद्धि\n\nकेंद्रीय कृषि मंत्री  शिवराज सिंह ने कहा कि इन जोनल कॉन्फ्रेंसों का मुख्य उद्देश्य केंद्र और राज्यों के बीच समन्वय को और मजबूत करना तथा स्थानीय परिस्थितियों के अनुरूप केंद्रीय योजनाओं का प्रभावी क्रियान्वयन सुनिश्चित करना है, जैसा कि प्रधानमंत्री  नरेंद्र मोदी का संकल्प और दिशा-निर्देश भी रहा है। इन बैठकों में आत्मनिर्भर दलहन मिशन, राष्ट्रीय खाद्य तेल मिशन, प्राकृतिक खेती मिशन, डिजिटल एग्रीकल्चर मिशन जैसी प्राथमिकताओं पर विस्तृत चर्चा होगी और बाधाओं की पहचान कर समाधान तय किए जाएंगे। राज्यों के सफल मॉडल, जैसे सिंचाई, उर्वरक वितरण, एग्री‑स्टैक, बागवानी और मूल्य श्रृंखला प्रबंधन की सर्वोत्तम प्रथाओं को साझा कर अन्य राज्यों में भी लागू करने की रूपरेखा बनेगी।\n\n	2026-04-01 20:30:52.532837	2026-04-01 20:30:52.532837	
\.


--
-- Data for Name: scheme_translations; Type: TABLE DATA; Schema: public; Owner: yuvraj
--

COPY public.scheme_translations (id, scheme_id, language_code, name, description, benefits, eligibility, application_process) FROM stdin;
43	26	en	Pradhan Mantri Fasal Bima Yojana (PMFBY)	Pradhan Mantri Fasal Bima Yojana (PMFBY) is a crop insurance scheme launched by the Government of India to protect farmers against crop loss or damage due to natural disasters, pests, and diseases.\n\nThe scheme provides financial support to farmers in case of crop failure, ensuring income stability and encouraging farmers to adopt modern agricultural practices. It aims to reduce farmers’ financial risk and promote sustainable agriculture.\n\nUnder PMFBY, farmers pay a very low premium, while the remaining insurance premium is subsidized by the Central and State Governments.	["Provides insurance coverage and financial support for crop loss or damage.", "Protects farmers against natural disasters such as drought, flood, cyclone, hailstorm, and landslides.", "Covers losses due to pests and crop diseases.", "Farmers pay very low premium rates: 2% for Kharif crops, 1.5% for Rabi crops, 5% for commercial and horticultural crops.", "The remaining premium amount is shared by the Central and State Governments.", "Encourages farmers to adopt modern and innovative agricultural practices.", "Helps stabilize farmer income during crop failure.", "Provides post-harvest loss coverage (up to 14 days in certain conditions).", "Uses technology like remote sensing, drones, and satellite data for crop loss assessment."]	["Applicant must be an Indian citizen.", "Must be a farmer cultivating notified crops in notified areas.", "Both loanee and non-loanee farmers can apply.", "Farmers growing food crops, oilseeds, commercial crops, or horticultural crops can apply.", "The farmer must have insurable interest in the crop.", "Must register before the crop insurance deadline set by the government.", "Tenant farmers and sharecroppers are also eligible (subject to state rules).", "Not Eligible - Farmers not growing notified crops in notified areas, Farmers who do not enroll before the deadline, Farmers without proof of land ownership or cultivation rights (where required), Individuals not engaged in agricultural activities, Crops not covered under the scheme in that particular region or season. "]	["Visit the official website: https://pmfby.gov.in .", "Click on “Farmer Corner”.", "Select “Apply for Crop Insurance”.", "Register using:  Aadhaar number/ Mobile number", "Fill in required details:  Farmer information, Land details, Crop details, Season (Kharif/Rabi)", "Upload required documents.", "Pay the farmer premium amount.", "Submit the application.", "After verification, the farmer receives insurance coverage for the crop season.", "Farmers can also apply through: Banks (for loanee farmers), Common Service Centres (CSC), Agriculture department offices, Authorized insurance companies participating in PMFBY."]
44	27	en	Pradhan Mantri Krishi Sinchai Yojana (PMKSY)	Pradhan Mantri Krishi Sinchai Yojana (PMKSY) is a central government scheme aimed at improving irrigation facilities for farmers across India.\n\nThe main objective of the scheme is “Har Khet Ko Pani” (water to every field) and “More Crop Per Drop”, which focuses on efficient water usage in agriculture.\n\nPMKSY integrates different irrigation schemes and promotes micro-irrigation technologies such as drip and sprinkler irrigation to increase water efficiency and agricultural productivity.	["Ensures irrigation water reaches every agricultural field (Har Khet Ko Pani).", "Promotes efficient water usage through micro-irrigation techniques.", "Encourages use of drip irrigation and sprinkler irrigation systems.", "Improves agricultural productivity and crop yield.", "Helps conserve water resources.", "Reduces water wastage in agriculture.", "Supports sustainable farming practices.", "Provides financial assistance/subsidy for irrigation equipment and infrastructure.", "Enhances farmers’ income through better crop production."]	["Applicant must be an Indian citizen.", "Must be a farmer engaged in agricultural activities.", "Must have cultivable agricultural land.", "Farmers interested in installing micro-irrigation systems (drip or sprinkler) can apply.", "Both individual farmers and farmer groups/cooperatives can apply.", "Farmers must register through the state agriculture or irrigation department.", "Farmers must follow guidelines set by the state government for irrigation projects.", "Not Eligible - Individuals not involved in farming or agriculture , Applicants without cultivable agricultural land , Projects not related to irrigation or water management , Applicants providing false land or farming information , Land not approved under state irrigation development plans ."]	["Farmers can apply through state agriculture or irrigation departments.", "Visit the official website: https://pmksy.gov.in .", "Contact the state agriculture or irrigation department.", "Fill the PMKSY application form.", "Provide required details:  Farmer information/ Land details/ Irrigation requirement.", "Submit required documents.", "The application is verified by the agriculture department.", "After approval, farmers receive financial assistance or subsidy for irrigation facilities.", "Farmers can also apply through:  State Agriculture Department offices/ Common Service Centres (CSC)/ District irrigation departments/ Agriculture extension officers or Krishi Vigyan Kendras (KVKs)."]
45	28	en	Soil Health Card Scheme	The Soil Health Card Scheme is a Government of India initiative to help farmers understand the nutrient status of their soil. Under this scheme, farmers are provided with a Soil Health Card (SHC) that contains detailed information about the nutrient levels and fertility of their soil.\n\nThe scheme helps farmers use the right amount of fertilizers and nutrients, improving crop productivity and maintaining soil health. Soil samples are tested in laboratories, and recommendations are given for appropriate fertilizer use and soil improvement practices.\n\nThe Soil Health Card is generally issued every two years to farmers.	["Provides scientific information about soil nutrient status.", "Helps farmers apply the correct amount of fertilizers and nutrients.", "Improves soil fertility and soil health.", "Increases crop productivity and yield.", "Reduces excessive use of chemical fertilizers.", "Promotes balanced fertilizer usage.", "Helps reduce farming costs for farmers.", "Supports sustainable agriculture practices.", "Provides crop-wise fertilizer recommendations to farmers."]	["Applicant must be an Indian citizen.", "Must be a farmer engaged in agricultural activities.", "Must have agricultural land for cultivation.", "Both small and large farmers can receive soil health cards.", "Farmers whose soil samples are collected for testing by agriculture departments.", "Farmers registered with state agriculture departments or soil testing programs.", "Not Eligible - Individuals not engaged in farming activities, Applicants without agricultural land, Land not used for cultivation, Individuals providing incorrect land or soil information, Applicants whose soil samples are not collected or tested under the scheme. "]	["Farmers can apply for the Soil Health Card through agriculture departments.", "Visit the official website: https://soilhealth.dac.gov.in", "Contact the local agriculture department or soil testing laboratory.", "Submit a request for soil sample testing.", "Agriculture officers collect soil samples from the farmer’s field.", "Soil samples are tested in government laboratories.", "Based on test results, a Soil Health Card is prepared.", "The card is issued to the farmer with fertilizer and nutrient recommendations.", "Farmers can also apply through:  State Agriculture Department offices. Common Service Centres (CSC). Krishi Vigyan Kendras (KVKs). Government soil testing laboratories."]
47	30	en	Bhavantar Bhugtan Yojana (BBY)	Bhavantar Bhugtan Yojana is a price deficiency payment scheme launched by the Government of Madhya Pradesh to protect farmers from losses caused by falling crop prices.\n\nUnder this scheme, if farmers sell their crops in the market at a price lower than the Minimum Support Price (MSP), the government pays the difference between the MSP and the market (model) price directly to the farmer.\n\nThe aim of the scheme is to ensure farmers receive a fair price for their crops and are protected from market price fluctuations.\n\nInitially the scheme covered 8 crops, mainly oilseeds and pulses, and later it was extended to 13 crops.	["Provides compensation when crop market price falls below MSP.", "Protects farmers from losses due to price fluctuations in agricultural markets.", "The difference between MSP and market price is paid directly to farmers.", "Payment is transferred directly to the farmer’s bank account through DBT.", "Encourages farmers to grow oilseeds and pulses.", "Helps farmers receive fair value for their agricultural produce.", "Reduces the impact of distress selling in agricultural markets.", "Covers both Kharif and Rabi crops depending on government notification."]	["Applicant must be a resident of Madhya Pradesh.", "Must be a farmer engaged in agricultural activities.", "Farmer must register under the Bhavantar Bhugtan Yojana.", "Farmer must sell crops in registered agricultural mandis (markets).", "Crops sold must be notified crops under the scheme.", "Farmer must provide valid bank account details for DBT payment.", "Land and crop details must be verified by the agriculture department.", "Not Eligible (Excluded Categories) :  Individuals not engaged in farming activities. Farmers who do not register under the scheme. Farmers selling crops outside registered mandis. Crops not included in the scheme list. Individuals providing false land or crop information."]	["Visit the official portal: https://mpeuparjan.nic.in .", "Register under the Bhavantar Bhugtan Yojana.", "Provide required details:  Aadhaar number Farmer registration number Land details Crop details Bank account details", "Submit the application form.", "Sell the crops in registered agricultural mandis.", "Government calculates the difference between MSP and model price.", "Compensation amount is transferred to the farmer’s bank account.", "Farmers can also apply through:  Agriculture produce market committees (APMC mandis). Local agriculture department offices. Common Service Centres (CSC). District agriculture offices."]
46	29	en	Mukhyamantri Kisan Kalyan Yojana (MKKY)	Mukhyamantri Kisan Kalyan Yojana is a state government scheme launched by the Government of Madhya Pradesh to provide additional financial support to farmers.\n\nThe scheme works alongside Pradhan Mantri Kisan Samman Nidhi, under which farmers already receive ₹6,000 per year from the central government. Under the Mukhyamantri Kisan Kalyan Yojana, the Madhya Pradesh government provides an additional ₹6,000 per year, helping farmers increase their income and meet agricultural expenses.\n\nThe money is transferred directly into farmers’ bank accounts through Direct Benefit Transfer (DBT).	["Provides ₹6,000 financial assistance per year to eligible farmers.", "Amount is given in 3 installments of ₹2,000 each.", "Money is transferred directly to bank accounts through DBT.", "Farmers receiving PM-KISAN benefits get additional financial support from the state government.", "Helps farmers buy seeds, fertilizers, and farming inputs.", "Supports income stability for farmers in Madhya Pradesh.", "Encourages modern farming practices and agricultural development."]	["Applicant must be a permanent resident of Madhya Pradesh.", "Must be a farmer engaged in agricultural activities.", "Must have cultivable agricultural land.", "Farmer must be registered under PM-KISAN scheme.", "Aadhaar and bank account must be linked for DBT transfer.", "Farmer details must be verified by the local revenue department or patwari.", "Not Eligible (Excluded Categories) - Individuals not registered under PM-KISAN. People not residing in Madhya Pradesh. Individuals not engaged in farming activities. Income tax payers. Government employees or elected representatives. Applicants providing incorrect land or personal information."]	["Farmers must first register under PM-KISAN.", "Visit the local patwari or revenue office.", "Fill the Mukhyamantri Kisan Kalyan Yojana application form.", "Provide required details:  Aadhaar number PM-KISAN registration number Land details Bank account details", "Submit required documents.", "The patwari verifies farmer details with PM-KISAN records.", "After verification, the farmer’s name is added to the eligible beneficiary list.", "Financial assistance is transferred directly to the bank account.", "Farmers can also apply through:  Local Patwari office. District revenue department offices. State agriculture department offices. Common Service Centres (CSC)."]
62	34	en	e-Choupal	e-Choupal is a digital agriculture initiative launched by ITC Limited to connect farmers directly with markets using the internet and digital technology.\n\nUnder this initiative, internet-enabled kiosks are installed in rural villages, which allow farmers to access information related to crop prices, weather forecasts, farming practices, and agricultural inputs.\n\nThe main goal of e-Choupal is to eliminate middlemen and enable farmers to sell their produce directly to companies at better prices, improving their income and decision-making ability.\n\nThe platform also provides agricultural knowledge, market information, and supply chain support, helping farmers adopt modern farming techniques.	["Provides real-time information about crop market prices.", "Helps farmers sell produce directly to companies without middlemen.", "Improves farmers’ bargaining power in agricultural markets.", "Provides weather forecasts and farming advice.", "Helps farmers buy quality seeds, fertilizers, and agricultural inputs.", "Reduces transaction costs and delays in agricultural trade.", "Improves transparency in crop pricing.", "Promotes digital literacy among rural farmers.", "Enhances farm productivity through better agricultural knowledge."]	["Applicant must be an Indian farmer engaged in agricultural activities.", "Must live in a village where an e-Choupal kiosk is established.", "Farmers interested in getting agricultural information or selling produce through the platform can participate.", "Farmers must register with the local e-Choupal operator (called a Sanchalak).", "Farmers growing crops supported by the e-Choupal procurement system can participate.", "Not Eligible (Excluded Categories) : Individuals not engaged in farming activities. Farmers living in areas where e-Choupal facilities are not available. Individuals not registered with the local e-Choupal network. Farmers selling crops not handled through the e-Choupal system."]	["Visit the nearest e-Choupal kiosk in the village.", "Contact the local Sanchalak (trained farmer managing the kiosk).", "Register with the e-Choupal network.", "Farmers can access services such as: Market price information, Weather forecasts, Farming advice.", "Farmers can sell their produce through the e-Choupal procurement system.", "Payment is made directly to the farmer according to market rates.", "Farmers can access e-Choupal services through: Village e-Choupal internet kiosks, Local Sanchalak (village coordinator), ITC procurement centers linked with e-Choupal, Rural supply chain networks managed by ITC."]
63	34	hi	ई-चौपाल	ई-चौपाल आईटीसी लिमिटेड द्वारा शुरू की गई एक डिजिटल कृषि पहल है जिसका उद्देश्य इंटरनेट और डिजिटल तकनीक का उपयोग करके किसानों को सीधे बाजारों से जोड़ना है।\n\nइस पहल के तहत ग्रामीण गांवों में इंटरनेट से जुड़े कियोस्क स्थापित किए जाते हैं, जिनके माध्यम से किसान फसल की कीमत, मौसम पूर्वानुमान, खेती की तकनीक और कृषि इनपुट से संबंधित जानकारी प्राप्त कर सकते हैं।\n\nई-चौपाल का मुख्य उद्देश्य बिचौलियों को हटाना और किसानों को अपनी उपज सीधे कंपनियों को बेहतर कीमत पर बेचने में सक्षम बनाना है, जिससे उनकी आय और निर्णय लेने की क्षमता में सुधार होता है।\n\nयह प्लेटफॉर्म किसानों को कृषि ज्ञान, बाजार जानकारी और सप्लाई चेन सहायता भी प्रदान करता है, जिससे वे आधुनिक खेती तकनीकों को अपनाने में सक्षम होते हैं।	["फसल के बाजार मूल्यों की वास्तविक समय में जानकारी प्रदान करता है।", "किसानों को बिना बिचौलियों के सीधे कंपनियों को फसल बेचने में मदद करता है।", "कृषि बाजारों में किसानों की सौदेबाजी शक्ति बढ़ाता है।", "मौसम पूर्वानुमान और खेती से संबंधित सलाह प्रदान करता है।", "किसानों को अच्छी गुणवत्ता के बीज, उर्वरक और कृषि इनपुट खरीदने में मदद करता है।", "कृषि व्यापार में लेन-देन की लागत और देरी को कम करता है।", "फसल मूल्य निर्धारण में पारदर्शिता बढ़ाता है।", "ग्रामीण किसानों में डिजिटल साक्षरता को बढ़ावा देता है।", "बेहतर कृषि ज्ञान के माध्यम से कृषि उत्पादकता बढ़ाता है।"]	["आवेदक भारतीय किसान होना चाहिए जो कृषि गतिविधियों में संलग्न हो।", "आवेदक ऐसे गांव में रहता हो जहां ई-चौपाल कियोस्क स्थापित हो।", "जो किसान कृषि जानकारी प्राप्त करना या इस प्लेटफॉर्म के माध्यम से अपनी फसल बेचना चाहते हैं, वे भाग ले सकते हैं।", "किसानों को स्थानीय ई-चौपाल संचालक (जिसे संचालक कहा जाता है) के साथ पंजीकरण करना होगा।", "ई-चौपाल खरीद प्रणाली द्वारा समर्थित फसल उगाने वाले किसान भाग ले सकते हैं।", "अयोग्य श्रेणी: जो व्यक्ति खेती में संलग्न नहीं हैं। ऐसे किसान जो उन क्षेत्रों में रहते हैं जहां ई-चौपाल सुविधा उपलब्ध नहीं है। जो लोग स्थानीय ई-चौपाल नेटवर्क में पंजीकृत नहीं हैं। ऐसे किसान जो ऐसी फसलें बेचते हैं जिन्हें ई-चौपाल प्रणाली संभालती नहीं है।"]	["गांव में स्थित नजदीकी ई-चौपाल कियोस्क पर जाएं।", "स्थानीय संचालक (कियोस्क का संचालन करने वाला प्रशिक्षित किसान) से संपर्क करें।", "ई-चौपाल नेटवर्क में पंजीकरण करें।", "किसान निम्न सेवाओं का उपयोग कर सकते हैं: बाजार मूल्य जानकारी, मौसम पूर्वानुमान, खेती से संबंधित सलाह।", "किसान अपनी उपज ई-चौपाल खरीद प्रणाली के माध्यम से बेच सकते हैं।", "भुगतान बाजार दरों के अनुसार सीधे किसान के खाते में किया जाता है।", "किसान निम्न माध्यमों से ई-चौपाल सेवाओं का उपयोग कर सकते हैं: गांव के ई-चौपाल इंटरनेट कियोस्क, स्थानीय संचालक (गांव समन्वयक), ई-चौपाल से जुड़े आईटीसी खरीद केंद्र, आईटीसी द्वारा प्रबंधित ग्रामीण सप्लाई चेन नेटवर्क।"]
64	34	pa	ਈ-ਚੌਪਾਲ	ਈ-ਚੌਪਾਲ ਆਈਟੀਸੀ ਲਿਮਿਟੇਡ ਵੱਲੋਂ ਸ਼ੁਰੂ ਕੀਤੀ ਗਈ ਇੱਕ ਡਿਜ਼ਿਟਲ ਖੇਤੀਬਾੜੀ ਪਹਲ ਹੈ ਜਿਸਦਾ ਉਦੇਸ਼ ਇੰਟਰਨੈੱਟ ਅਤੇ ਡਿਜ਼ਿਟਲ ਤਕਨਾਲੋਜੀ ਦੀ ਵਰਤੋਂ ਕਰਕੇ ਕਿਸਾਨਾਂ ਨੂੰ ਸਿੱਧੇ ਮਾਰਕੀਟਾਂ ਨਾਲ ਜੋੜਨਾ ਹੈ।\n\nਇਸ ਪਹਲ ਦੇ ਤਹਿਤ ਪਿੰਡਾਂ ਵਿੱਚ ਇੰਟਰਨੈੱਟ ਨਾਲ ਜੁੜੇ ਕਿਓਸਕ ਲਗਾਏ ਜਾਂਦੇ ਹਨ, ਜਿਸ ਨਾਲ ਕਿਸਾਨਾਂ ਨੂੰ ਫਸਲਾਂ ਦੇ ਮਾਰਕੀਟ ਭਾਅ, ਮੌਸਮ ਦੀ ਭਵਿੱਖਬਾਣੀ, ਖੇਤੀਬਾੜੀ ਤਰੀਕਿਆਂ ਅਤੇ ਖੇਤੀ ਇਨਪੁਟਾਂ ਬਾਰੇ ਜਾਣਕਾਰੀ ਮਿਲਦੀ ਹੈ।\n\nਈ-ਚੌਪਾਲ ਦਾ ਮੁੱਖ ਉਦੇਸ਼ ਦਲਾਲਾਂ ਨੂੰ ਘਟਾਉਣਾ ਅਤੇ ਕਿਸਾਨਾਂ ਨੂੰ ਆਪਣੀ ਫਸਲ ਸਿੱਧੇ ਕੰਪਨੀਆਂ ਨੂੰ ਵਧੀਆ ਕੀਮਤ ’ਤੇ ਵੇਚਣ ਯੋਗ ਬਣਾਉਣਾ ਹੈ, ਜਿਸ ਨਾਲ ਉਹਨਾਂ ਦੀ ਆਮਦਨ ਅਤੇ ਫੈਸਲਾ ਕਰਨ ਦੀ ਸਮਰੱਥਾ ਵਿੱਚ ਸੁਧਾਰ ਹੁੰਦਾ ਹੈ।\n\nਇਹ ਪਲੇਟਫਾਰਮ ਕਿਸਾਨਾਂ ਨੂੰ ਖੇਤੀਬਾੜੀ ਜਾਣਕਾਰੀ, ਮਾਰਕੀਟ ਜਾਣਕਾਰੀ ਅਤੇ ਸਪਲਾਈ ਚੇਨ ਸਹਾਇਤਾ ਵੀ ਪ੍ਰਦਾਨ ਕਰਦਾ ਹੈ, ਜਿਸ ਨਾਲ ਉਹ ਆਧੁਨਿਕ ਖੇਤੀ ਤਕਨੀਕਾਂ ਅਪਣਾ ਸਕਦੇ ਹਨ।	["ਫਸਲਾਂ ਦੇ ਮਾਰਕੀਟ ਭਾਅ ਬਾਰੇ ਰੀਅਲ-ਟਾਈਮ ਜਾਣਕਾਰੀ ਪ੍ਰਦਾਨ ਕਰਦਾ ਹੈ।", "ਕਿਸਾਨਾਂ ਨੂੰ ਬਿਨਾਂ ਦਲਾਲਾਂ ਦੇ ਸਿੱਧੇ ਕੰਪਨੀਆਂ ਨੂੰ ਫਸਲ ਵੇਚਣ ਵਿੱਚ ਮਦਦ ਕਰਦਾ ਹੈ।", "ਖੇਤੀਬਾੜੀ ਮਾਰਕੀਟਾਂ ਵਿੱਚ ਕਿਸਾਨਾਂ ਦੀ ਮੋਲ-ਭਾਅ ਸਮਰੱਥਾ ਵਧਾਉਂਦਾ ਹੈ।", "ਮੌਸਮ ਦੀ ਭਵਿੱਖਬਾਣੀ ਅਤੇ ਖੇਤੀਬਾੜੀ ਸਲਾਹ ਦਿੰਦਾ ਹੈ।", "ਕਿਸਾਨਾਂ ਨੂੰ ਵਧੀਆ ਗੁਣਵੱਤਾ ਵਾਲੇ ਬੀਜ, ਖਾਦ ਅਤੇ ਖੇਤੀ ਇਨਪੁਟ ਖਰੀਦਣ ਵਿੱਚ ਮਦਦ ਕਰਦਾ ਹੈ।", "ਖੇਤੀਬਾੜੀ ਵਪਾਰ ਵਿੱਚ ਲੈਣ-ਦੇਣ ਦੀ ਲਾਗਤ ਅਤੇ ਦੇਰੀ ਘਟਾਉਂਦਾ ਹੈ।", "ਫਸਲਾਂ ਦੀ ਕੀਮਤ ਨਿਰਧਾਰਨ ਵਿੱਚ ਪਾਰਦਰਸ਼ਤਾ ਵਧਾਉਂਦਾ ਹੈ।", "ਪਿੰਡਾਂ ਦੇ ਕਿਸਾਨਾਂ ਵਿੱਚ ਡਿਜ਼ਿਟਲ ਸਾਖਰਤਾ ਨੂੰ ਉਤਸ਼ਾਹਿਤ ਕਰਦਾ ਹੈ।", "ਵਧੀਆ ਖੇਤੀਬਾੜੀ ਗਿਆਨ ਰਾਹੀਂ ਫਸਲ ਉਤਪਾਦਕਤਾ ਵਧਾਉਂਦਾ ਹੈ।"]	["ਆਵੇਦਕ ਭਾਰਤੀ ਕਿਸਾਨ ਹੋਣਾ ਚਾਹੀਦਾ ਹੈ ਜੋ ਖੇਤੀਬਾੜੀ ਗਤੀਵਿਧੀਆਂ ਵਿੱਚ ਸ਼ਾਮਲ ਹੋਵੇ।", "ਉਹ ਪਿੰਡ ਵਿੱਚ ਰਹਿੰਦਾ ਹੋਵੇ ਜਿੱਥੇ ਈ-ਚੌਪਾਲ ਕਿਓਸਕ ਸਥਾਪਿਤ ਹੈ।", "ਜੋ ਕਿਸਾਨ ਖੇਤੀਬਾੜੀ ਜਾਣਕਾਰੀ ਲੈਣਾ ਜਾਂ ਇਸ ਪਲੇਟਫਾਰਮ ਰਾਹੀਂ ਆਪਣੀ ਫਸਲ ਵੇਚਣਾ ਚਾਹੁੰਦੇ ਹਨ ਉਹ ਹਿੱਸਾ ਲੈ ਸਕਦੇ ਹਨ।", "ਕਿਸਾਨਾਂ ਨੂੰ ਸਥਾਨਕ ਈ-ਚੌਪਾਲ ਸੰਚਾਲਕ (ਸੰਚਾਲਕ) ਕੋਲ ਰਜਿਸਟ੍ਰੇਸ਼ਨ ਕਰਵਾਉਣਾ ਲਾਜ਼ਮੀ ਹੈ।", "ਈ-ਚੌਪਾਲ ਖਰੀਦ ਪ੍ਰਣਾਲੀ ਦੁਆਰਾ ਸਮਰਥਿਤ ਫਸਲਾਂ ਉਗਾਉਣ ਵਾਲੇ ਕਿਸਾਨ ਹਿੱਸਾ ਲੈ ਸਕਦੇ ਹਨ।", "ਅਯੋਗ ਸ਼੍ਰੇਣੀ: ਜੋ ਵਿਅਕਤੀ ਖੇਤੀਬਾੜੀ ਨਾਲ ਸੰਬੰਧਤ ਨਹੀਂ ਹਨ। ਉਹ ਕਿਸਾਨ ਜੋ ਉਹਨਾਂ ਖੇਤਰਾਂ ਵਿੱਚ ਰਹਿੰਦੇ ਹਨ ਜਿੱਥੇ ਈ-ਚੌਪਾਲ ਸਹੂਲਤ ਉਪਲਬਧ ਨਹੀਂ ਹੈ। ਉਹ ਵਿਅਕਤੀ ਜੋ ਸਥਾਨਕ ਈ-ਚੌਪਾਲ ਨੈੱਟਵਰਕ ਵਿੱਚ ਰਜਿਸਟਰ ਨਹੀਂ ਹਨ। ਉਹ ਕਿਸਾਨ ਜੋ ਉਹ ਫਸਲਾਂ ਵੇਚਦੇ ਹਨ ਜੋ ਈ-ਚੌਪਾਲ ਪ੍ਰਣਾਲੀ ਦੁਆਰਾ ਸੰਭਾਲੀਆਂ ਨਹੀਂ ਜਾਂਦੀਆਂ।"]	["ਪਿੰਡ ਦੇ ਸਭ ਤੋਂ ਨੇੜਲੇ ਈ-ਚੌਪਾਲ ਕਿਓਸਕ ਤੇ ਜਾਓ।", "ਸਥਾਨਕ ਸੰਚਾਲਕ (ਕਿਓਸਕ ਚਲਾਉਣ ਵਾਲਾ ਪ੍ਰਸ਼ਿਕਸ਼ਿਤ ਕਿਸਾਨ) ਨਾਲ ਸੰਪਰਕ ਕਰੋ।", "ਈ-ਚੌਪਾਲ ਨੈੱਟਵਰਕ ਵਿੱਚ ਰਜਿਸਟਰ ਕਰੋ।", "ਕਿਸਾਨ ਹੇਠ ਲਿਖੀਆਂ ਸੇਵਾਵਾਂ ਵਰਤ ਸਕਦੇ ਹਨ: ਮਾਰਕੀਟ ਭਾਅ ਜਾਣਕਾਰੀ, ਮੌਸਮ ਦੀ ਭਵਿੱਖਬਾਣੀ, ਖੇਤੀਬਾੜੀ ਸਲਾਹ।", "ਕਿਸਾਨ ਆਪਣੀ ਫਸਲ ਈ-ਚੌਪਾਲ ਖਰੀਦ ਪ੍ਰਣਾਲੀ ਰਾਹੀਂ ਵੇਚ ਸਕਦੇ ਹਨ।", "ਭੁਗਤਾਨ ਮਾਰਕੀਟ ਦਰਾਂ ਅਨੁਸਾਰ ਸਿੱਧੇ ਕਿਸਾਨ ਦੇ ਖਾਤੇ ਵਿੱਚ ਕੀਤਾ ਜਾਂਦਾ ਹੈ।", "ਕਿਸਾਨ ਹੇਠ ਲਿਖੇ ਮਾਧਿਅਮਾਂ ਰਾਹੀਂ ਈ-ਚੌਪਾਲ ਸੇਵਾਵਾਂ ਲੈ ਸਕਦੇ ਹਨ: ਪਿੰਡ ਦੇ ਈ-ਚੌਪਾਲ ਇੰਟਰਨੈੱਟ ਕਿਓਸਕ, ਸਥਾਨਕ ਸੰਚਾਲਕ (ਪਿੰਡ ਕੋਆਰਡੀਨੇਟਰ), ਈ-ਚੌਪਾਲ ਨਾਲ ਜੁੜੇ ITC ਖਰੀਦ ਕੇਂਦਰ, ITC ਦੁਆਰਾ ਪ੍ਰਬੰਧਿਤ ਪਿੰਡਾਂ ਦੀ ਸਪਲਾਈ ਚੇਨ ਨੈੱਟਵਰਕ।"]
65	34	gu	ઈ-ચોપાલ	ઈ-ચોપાલ એ ITC લિમિટેડ દ્વારા શરૂ કરવામાં આવેલી એક ડિજિટલ કૃષિ પહેલ છે જેનો ઉદ્દેશ ઈન્ટરનેટ અને ડિજિટલ ટેકનોલોજી દ્વારા ખેડૂતોને સીધા બજારો સાથે જોડવાનો છે.\n\nઆ પહેલ હેઠળ ગ્રામ્ય ગામોમાં ઈન્ટરનેટ સક્ષમ કિયોસ્ક સ્થાપિત કરવામાં આવે છે, જેના દ્વારા ખેડૂતોને પાકના બજાર ભાવ, હવામાનની આગાહી, ખેતી પદ્ધતિઓ અને કૃષિ ઇનપુટ્સ વિશે માહિતી મળે છે.\n\nઈ-ચોપાલનો મુખ્ય ઉદ્દેશ મધ્યસ્થીઓને ઘટાડવાનો અને ખેડૂતોને તેમની ઉપજ સીધી કંપનીઓને વધુ સારી કિંમતે વેચવાની તક આપવાનો છે, જેથી તેમની આવક અને નિર્ણય ક્ષમતા વધે.\n\nઆ પ્લેટફોર્મ કૃષિ જ્ઞાન, બજાર માહિતી અને સપ્લાય ચેઇન સપોર્ટ પણ પ્રદાન કરે છે, જે ખેડૂતોને આધુનિક ખેતી પદ્ધતિઓ અપનાવવામાં મદદ કરે છે.	["પાકના બજાર ભાવ વિશે રિયલ-ટાઈમ માહિતી આપે છે.", "ખેડૂતોને મધ્યસ્થીઓ વગર સીધા કંપનીઓને ઉપજ વેચવામાં મદદ કરે છે.", "કૃષિ બજારમાં ખેડૂતોની સોદાકીય શક્તિ વધારે છે.", "હવામાનની આગાહી અને ખેતી સંબંધિત માર્ગદર્શન આપે છે.", "ખેડૂતોને ગુણવત્તાવાળા બીજ, ખાતર અને કૃષિ ઇનપુટ ખરીદવામાં મદદ કરે છે.", "કૃષિ વેપારમાં વ્યવહાર ખર્ચ અને વિલંબ ઘટાડે છે.", "પાકના ભાવ નિર્ધારણમાં પારદર્શિતા વધારે છે.", "ગ્રામ્ય ખેડૂતોમાં ડિજિટલ સાક્ષરતાને પ્રોત્સાહિત કરે છે.", "સારી કૃષિ માહિતી દ્વારા ખેતી ઉત્પાદનક્ષમતા વધારે છે."]	["અરજદાર ભારતીય ખેડૂત હોવો જોઈએ અને કૃષિ પ્રવૃત્તિમાં સંકળાયેલો હોવો જોઈએ.", "તે ગામમાં રહેતો હોવો જોઈએ જ્યાં ઈ-ચોપાલ કિયોસ્ક સ્થાપિત હોય.", "ખેડૂતો જે કૃષિ માહિતી મેળવવા અથવા આ પ્લેટફોર્મ દ્વારા ઉપજ વેચવા ઈચ્છે છે તે ભાગ લઈ શકે છે.", "ખેડૂતોએ સ્થાનિક ઈ-ચોપાલ સંચાલક (સંચાલક) પાસે નોંધણી કરાવવી જરૂરી છે.", "ઈ-ચોપાલ ખરીદી પ્રણાલી દ્વારા સમર્થિત પાક ઉગાડતા ખેડૂતો ભાગ લઈ શકે છે.", "અયોગ્ય શ્રેણી: કૃષિ સાથે સંબંધિત ન હોય એવા વ્યક્તિઓ. એવા ખેડૂતો જે એવા વિસ્તારમાં રહે છે જ્યાં ઈ-ચોપાલ સુવિધા ઉપલબ્ધ નથી. સ્થાનિક ઈ-ચોપાલ નેટવર્કમાં નોંધણી ન કરાવેલા વ્યક્તિઓ. એવા ખેડૂતો જે એવા પાક વેચે છે જે ઈ-ચોપાલ સિસ્ટમ દ્વારા સંભાળવામાં આવતા નથી."]	["ગામના નજીકના ઈ-ચોપાલ કિયોસ્ક પર જાઓ.", "સ્થાનિક સંચાલક (કિયોસ્ક ચલાવતો પ્રશિક્ષિત ખેડૂત) સાથે સંપર્ક કરો.", "ઈ-ચોપાલ નેટવર્કમાં નોંધણી કરો.", "ખેડૂતો નીચેની સેવાઓ મેળવી શકે છે: બજાર ભાવ માહિતી, હવામાન આગાહી, ખેતી સલાહ.", "ખેડૂતો પોતાની ઉપજ ઈ-ચોપાલ ખરીદી પ્રણાલી દ્વારા વેચી શકે છે.", "ચુકવણી બજાર દર મુજબ સીધી ખેડૂતના ખાતામાં કરવામાં આવે છે.", "ખેડૂતો નીચેના માધ્યમો દ્વારા ઈ-ચોપાલ સેવાઓ મેળવી શકે છે: ગામના ઈ-ચોપાલ ઈન્ટરનેટ કિયોસ્ક, સ્થાનિક સંચાલક (ગામ સંયોજક), ઈ-ચોપાલ સાથે જોડાયેલા ITC ખરીદી કેન્દ્રો, ITC દ્વારા સંચાલિત ગ્રામ્ય સપ્લાય ચેઇન નેટવર્ક."]
66	34	ta	இ-சௌபால்	இ-சௌபால் என்பது ITC லிமிடெட் நிறுவனம் தொடங்கிய ஒரு டிஜிட்டல் வேளாண்மை முயற்சி ஆகும். இதன் நோக்கம் இணையம் மற்றும் டிஜிட்டல் தொழில்நுட்பத்தின் மூலம் விவசாயிகளை நேரடியாக சந்தைகளுடன் இணைப்பதாகும்.\n\nஇந்த முயற்சியின் கீழ் கிராமங்களில் இணைய வசதி கொண்ட கியோஸ்க்கள் நிறுவப்படுகின்றன. இதன் மூலம் விவசாயிகள் பயிர்களின் சந்தை விலை, வானிலை முன்னறிவிப்பு, விவசாய முறைகள் மற்றும் வேளாண்மை உள்ளீடுகள் பற்றிய தகவல்களை பெற முடியும்.\n\nஇ-சௌபாலின் முக்கிய நோக்கம் நடுவிலானவர்களை குறைத்து, விவசாயிகள் தங்கள் விளைபொருட்களை நேரடியாக நிறுவனங்களுக்கு சிறந்த விலையில் விற்க உதவுவதாகும். இதன் மூலம் அவர்களின் வருமானமும் முடிவெடுக்கும் திறனும் மேம்படுகிறது.\n\nஇந்த தளம் விவசாய அறிவு, சந்தை தகவல் மற்றும் விநியோக சங்கிலி ஆதரவையும் வழங்குகிறது, இதனால் விவசாயிகள் நவீன வேளாண்மை முறைகளை ஏற்க முடிகிறது.	["பயிர்களின் சந்தை விலைகள் பற்றிய நேரடி தகவலை வழங்குகிறது.", "விவசாயிகள் நடுவிலானவர்களின்றி நேரடியாக நிறுவனங்களுக்கு விளைபொருட்களை விற்க உதவுகிறது.", "வேளாண்மை சந்தைகளில் விவசாயிகளின் பேச்சுவார்த்தை சக்தியை அதிகரிக்கிறது.", "வானிலை முன்னறிவிப்பும் விவசாய ஆலோசனைகளும் வழங்கப்படுகிறது.", "உயர்தர விதைகள், உரங்கள் மற்றும் வேளாண்மை உள்ளீடுகளை வாங்க உதவுகிறது.", "வேளாண்மை வர்த்தகத்தில் பரிவர்த்தனை செலவுகளையும் தாமதங்களையும் குறைக்கிறது.", "பயிர் விலை நிர்ணயத்தில் வெளிப்படைத்தன்மையை அதிகரிக்கிறது.", "கிராமப்புற விவசாயிகளில் டிஜிட்டல் அறிவாற்றலை ஊக்குவிக்கிறது.", "சிறந்த வேளாண்மை அறிவின் மூலம் விளைச்சலை அதிகரிக்க உதவுகிறது."]	["விண்ணப்பதாரர் இந்திய விவசாயியாக இருக்க வேண்டும் மற்றும் வேளாண்மை செயல்பாடுகளில் ஈடுபட்டிருக்க வேண்டும்.", "இ-சௌபால் கியோஸ்க் அமைந்துள்ள கிராமத்தில் வசிக்க வேண்டும்.", "வேளாண்மை தகவல்களை பெற விரும்பும் அல்லது இந்த தளத்தின் மூலம் விளைபொருட்களை விற்க விரும்பும் விவசாயிகள் கலந்து கொள்ளலாம்.", "விவசாயிகள் உள்ளூர் இ-சௌபால் இயக்குநரிடம் பதிவு செய்ய வேண்டும்.", "இ-சௌபால் கொள்முதல் அமைப்பால் ஆதரிக்கப்படும் பயிர்களை வளர்க்கும் விவசாயிகள் கலந்து கொள்ளலாம்.", "தகுதி இல்லாதவர்கள்: வேளாண்மை செயல்பாடுகளில் ஈடுபடாதவர்கள். இ-சௌபால் வசதி இல்லாத பகுதிகளில் வாழும் விவசாயிகள். உள்ளூர் இ-சௌபால் வலையமைப்பில் பதிவு செய்யாதவர்கள். இ-சௌபால் அமைப்பில் கையாளப்படாத பயிர்களை விற்கும் விவசாயிகள்."]	["உங்கள் கிராமத்திற்கு அருகிலுள்ள இ-சௌபால் கியோஸ்கை பார்வையிடவும்.", "உள்ளூர் சஞ்சாலக் (கியோஸ்கை நிர்வகிக்கும் பயிற்சி பெற்ற விவசாயி) அவர்களை தொடர்பு கொள்ளவும்.", "இ-சௌபால் வலையமைப்பில் பதிவு செய்யவும்.", "விவசாயிகள் பின்வரும் சேவைகளை பெறலாம்: சந்தை விலை தகவல், வானிலை முன்னறிவிப்பு, விவசாய ஆலோசனை.", "விவசாயிகள் தங்கள் விளைபொருட்களை இ-சௌபால் கொள்முதல் முறையின் மூலம் விற்கலாம்.", "கட்டணம் சந்தை விலைக்கு ஏற்ப நேரடியாக விவசாயிகளுக்கு வழங்கப்படுகிறது.", "விவசாயிகள் பின்வரும் வழிகளில் இ-சௌபால் சேவைகளை பெறலாம்: கிராம இ-சௌபால் இணைய கியோஸ்க், உள்ளூர் சஞ்சாலக், ITC கொள்முதல் மையங்கள், ITC நிர்வகிக்கும் கிராம விநியோக சங்கிலி வலையமைப்பு."]
67	34	te	ఈ-చౌపాల్	ఈ-చౌపాల్ అనేది ITC లిమిటెడ్ ప్రారంభించిన ఒక డిజిటల్ వ్యవసాయ కార్యక్రమం. దీని లక్ష్యం ఇంటర్నెట్ మరియు డిజిటల్ సాంకేతికత ద్వారా రైతులను నేరుగా మార్కెట్లతో కలపడం.\n\nఈ కార్యక్రమం కింద గ్రామాలలో ఇంటర్నెట్ సదుపాయం ఉన్న కియోస్క్‌లు ఏర్పాటు చేయబడతాయి. వీటి ద్వారా రైతులు పంటల మార్కెట్ ధరలు, వాతావరణ అంచనాలు, వ్యవసాయ పద్ధతులు మరియు వ్యవసాయ ఇన్‌పుట్‌ల గురించి సమాచారం పొందవచ్చు.\n\nఈ-చౌపాల్ యొక్క ప్రధాన లక్ష్యం మధ్యవర్తులను తగ్గించడం మరియు రైతులు తమ పంటలను నేరుగా కంపెనీలకు మంచి ధరకు విక్రయించడానికి సహాయపడటం.\n\nఈ వేదిక వ్యవసాయ జ్ఞానం, మార్కెట్ సమాచారం మరియు సరఫరా గొలుసు మద్దతును కూడా అందిస్తుంది.	["పంటల మార్కెట్ ధరలపై రియల్ టైమ్ సమాచారం అందిస్తుంది.", "రైతులు మధ్యవర్తులు లేకుండా నేరుగా కంపెనీలకు పంటలను విక్రయించడానికి సహాయపడుతుంది.", "వ్యవసాయ మార్కెట్లలో రైతుల చర్చా శక్తిని పెంచుతుంది.", "వాతావరణ అంచనాలు మరియు వ్యవసాయ సలహాలు అందిస్తుంది.", "నాణ్యమైన విత్తనాలు, ఎరువులు మరియు వ్యవసాయ ఇన్‌పుట్‌లు కొనుగోలు చేయడానికి సహాయపడుతుంది.", "వ్యవసాయ వాణిజ్యంలో లావాదేవీ ఖర్చులు మరియు ఆలస్యాలను తగ్గిస్తుంది.", "పంటల ధరలలో పారదర్శకతను పెంచుతుంది.", "గ్రామీణ రైతుల్లో డిజిటల్ సాక్షరతను ప్రోత్సహిస్తుంది.", "మెరుగైన వ్యవసాయ జ్ఞానం ద్వారా దిగుబడిని పెంచుతుంది."]	["దరఖాస్తుదారు భారతీయ రైతు కావాలి మరియు వ్యవసాయ కార్యకలాపాలలో పాల్గొనాలి.", "ఈ-చౌపాల్ కియోస్క్ ఉన్న గ్రామంలో నివసించాలి.", "వ్యవసాయ సమాచారం పొందాలనుకునే లేదా ఈ వేదిక ద్వారా పంటలను అమ్మాలనుకునే రైతులు పాల్గొనవచ్చు.", "రైతులు స్థానిక ఈ-చౌపాల్ సంచాలక్ వద్ద నమోదు చేసుకోవాలి.", "ఈ-చౌపాల్ కొనుగోలు వ్యవస్థలో ఉన్న పంటలను పండించే రైతులు పాల్గొనవచ్చు.", "అర్హులు కానివారు: వ్యవసాయ కార్యకలాపాలలో పాల్గొనని వ్యక్తులు. ఈ-చౌపాల్ సౌకర్యం లేని ప్రాంతాలలో నివసించే రైతులు. స్థానిక ఈ-చౌపాల్ నెట్‌వర్క్‌లో నమోదు చేయని వ్యక్తులు. ఈ-చౌపాల్ వ్యవస్థలో లేని పంటలను విక్రయించే రైతులు."]	["మీ గ్రామానికి సమీపంలోని ఈ-చౌపాల్ కియోస్క్‌ను సందర్శించండి.", "స్థానిక సంచాలక్‌ను సంప్రదించండి.", "ఈ-చౌపాల్ నెట్‌వర్క్‌లో నమోదు చేసుకోండి.", "రైతులు ఈ సేవలను పొందవచ్చు: మార్కెట్ ధర సమాచారం, వాతావరణ అంచనాలు, వ్యవసాయ సలహాలు.", "రైతులు తమ పంటలను ఈ-చౌపాల్ కొనుగోలు వ్యవస్థ ద్వారా విక్రయించవచ్చు.", "చెల్లింపు మార్కెట్ ధరల ప్రకారం నేరుగా రైతుకు ఇవ్వబడుతుంది.", "రైతులు ఈ మార్గాల ద్వారా సేవలను పొందవచ్చు: గ్రామ ఈ-చౌపాల్ కియోస్క్‌లు, స్థానిక సంచాలక్, ITC కొనుగోలు కేంద్రాలు, ITC గ్రామీణ సరఫరా గొలుసు నెట్‌వర్క్."]
68	34	kn	ಇ-ಚೌಪಾಲ್	ಇ-ಚೌಪಾಲ್ ಎಂಬುದು ITC ಲಿಮಿಟೆಡ್ ಆರಂಭಿಸಿದ ಡಿಜಿಟಲ್ ಕೃಷಿ ಉಪಕ್ರಮವಾಗಿದೆ. ಇದರ ಉದ್ದೇಶ ಇಂಟರ್ನೆಟ್ ಮತ್ತು ಡಿಜಿಟಲ್ ತಂತ್ರಜ್ಞಾನದ ಮೂಲಕ ರೈತರನ್ನು ನೇರವಾಗಿ ಮಾರುಕಟ್ಟೆಗಳೊಂದಿಗೆ ಸಂಪರ್ಕಿಸುವುದು.\n\nಈ ಯೋಜನೆಯಡಿಯಲ್ಲಿ ಗ್ರಾಮಗಳಲ್ಲಿ ಇಂಟರ್ನೆಟ್ ಸೌಲಭ್ಯ ಹೊಂದಿರುವ ಕಿಯೋಸ್ಕ್‌ಗಳನ್ನು ಸ್ಥಾಪಿಸಲಾಗುತ್ತದೆ. ಇದರ ಮೂಲಕ ರೈತರು ಬೆಳೆಗಳ ಮಾರುಕಟ್ಟೆ ಬೆಲೆ, ಹವಾಮಾನ ಮುನ್ಸೂಚನೆ, ಕೃಷಿ ವಿಧಾನಗಳು ಮತ್ತು ಕೃಷಿ ಇನ್‌ಪುಟ್‌ಗಳ ಬಗ್ಗೆ ಮಾಹಿತಿ ಪಡೆಯಬಹುದು.\n\nಇ-ಚೌಪಾಲ್‌ನ ಮುಖ್ಯ ಉದ್ದೇಶ ಮಧ್ಯವರ್ತಿಗಳನ್ನು ಕಡಿಮೆ ಮಾಡುವುದು ಮತ್ತು ರೈತರಿಗೆ ತಮ್ಮ ಉತ್ಪನ್ನಗಳನ್ನು ನೇರವಾಗಿ ಕಂಪನಿಗಳಿಗೆ ಉತ್ತಮ ಬೆಲೆಯಲ್ಲಿ ಮಾರಾಟ ಮಾಡಲು ಸಹಾಯ ಮಾಡುವುದು.\n\nಈ ವೇದಿಕೆ ಕೃಷಿ ಜ್ಞಾನ, ಮಾರುಕಟ್ಟೆ ಮಾಹಿತಿ ಮತ್ತು ಸರಬರಾಜು ಸರಪಳಿ ಬೆಂಬಲವನ್ನು ಕೂಡ ಒದಗಿಸುತ್ತದೆ.	["ಬೆಳೆಗಳ ಮಾರುಕಟ್ಟೆ ಬೆಲೆಗಳ ಬಗ್ಗೆ ತಕ್ಷಣದ ಮಾಹಿತಿ ಒದಗಿಸುತ್ತದೆ.", "ರೈತರು ಮಧ್ಯವರ್ತಿಗಳಿಲ್ಲದೆ ನೇರವಾಗಿ ಕಂಪನಿಗಳಿಗೆ ಬೆಳೆಗಳನ್ನು ಮಾರಾಟ ಮಾಡಲು ಸಹಾಯ ಮಾಡುತ್ತದೆ.", "ಕೃಷಿ ಮಾರುಕಟ್ಟೆಗಳಲ್ಲಿ ರೈತರ ಮಾತುಕತೆ ಸಾಮರ್ಥ್ಯವನ್ನು ಹೆಚ್ಚಿಸುತ್ತದೆ.", "ಹವಾಮಾನ ಮುನ್ಸೂಚನೆ ಮತ್ತು ಕೃಷಿ ಸಲಹೆಗಳನ್ನು ನೀಡುತ್ತದೆ.", "ಗುಣಮಟ್ಟದ ಬೀಜಗಳು, ರಸಗೊಬ್ಬರಗಳು ಮತ್ತು ಕೃಷಿ ಇನ್‌ಪುಟ್‌ಗಳನ್ನು ಖರೀದಿಸಲು ಸಹಾಯ ಮಾಡುತ್ತದೆ.", "ಕೃಷಿ ವ್ಯಾಪಾರದಲ್ಲಿ ವ್ಯವಹಾರ ವೆಚ್ಚ ಮತ್ತು ವಿಳಂಬವನ್ನು ಕಡಿಮೆ ಮಾಡುತ್ತದೆ.", "ಬೆಳೆಗಳ ಬೆಲೆ ನಿರ್ಧಾರದಲ್ಲಿ ಪಾರದರ್ಶಕತೆಯನ್ನು ಹೆಚ್ಚಿಸುತ್ತದೆ.", "ಗ್ರಾಮೀಣ ರೈತರಲ್ಲಿ ಡಿಜಿಟಲ್ ಸಾಕ್ಷರತೆಯನ್ನು ಉತ್ತೇಜಿಸುತ್ತದೆ.", "ಉತ್ತಮ ಕೃಷಿ ಜ್ಞಾನದಿಂದ ಬೆಳೆ ಉತ್ಪಾದಕತೆಯನ್ನು ಹೆಚ್ಚಿಸುತ್ತದೆ."]	["ಅರ್ಜಿದಾರ ಭಾರತೀಯ ರೈತರಾಗಿರಬೇಕು ಮತ್ತು ಕೃಷಿ ಚಟುವಟಿಕೆಗಳಲ್ಲಿ ತೊಡಗಿರಬೇಕು.", "ಇ-ಚೌಪಾಲ್ ಕಿಯೋಸ್ಕ್ ಇರುವ ಗ್ರಾಮದಲ್ಲಿ ವಾಸಿಸುತ್ತಿರಬೇಕು.", "ಕೃಷಿ ಮಾಹಿತಿ ಪಡೆಯಲು ಅಥವಾ ಈ ವೇದಿಕೆಯ ಮೂಲಕ ಬೆಳೆಗಳನ್ನು ಮಾರಾಟ ಮಾಡಲು ಬಯಸುವ ರೈತರು ಭಾಗವಹಿಸಬಹುದು.", "ರೈತರು ಸ್ಥಳೀಯ ಇ-ಚೌಪಾಲ್ ಸಂಚಾಲಕರ ಬಳಿ ನೋಂದಣಿ ಮಾಡಿಕೊಳ್ಳಬೇಕು.", "ಇ-ಚೌಪಾಲ್ ಖರೀದಿ ವ್ಯವಸ್ಥೆಯಲ್ಲಿ ಒಳಗೊಂಡಿರುವ ಬೆಳೆಗಳನ್ನು ಬೆಳೆಯುವ ರೈತರು ಭಾಗವಹಿಸಬಹುದು.", "ಅರ್ಹರಲ್ಲದವರು: ಕೃಷಿ ಚಟುವಟಿಕೆಗಳಲ್ಲಿ ತೊಡಗಿಲ್ಲದವರು. ಇ-ಚೌಪಾಲ್ ಸೌಲಭ್ಯವಿಲ್ಲದ ಪ್ರದೇಶಗಳಲ್ಲಿ ವಾಸಿಸುವ ರೈತರು. ಸ್ಥಳೀಯ ಇ-ಚೌಪಾಲ್ ಜಾಲದಲ್ಲಿ ನೋಂದಾಯಿಸದವರು. ಇ-ಚೌಪಾಲ್ ವ್ಯವಸ್ಥೆಯಲ್ಲಿ ಒಳಗೊಂಡಿಲ್ಲದ ಬೆಳೆಗಳನ್ನು ಮಾರಾಟ ಮಾಡುವ ರೈತರು."]	["ನಿಮ್ಮ ಗ್ರಾಮದ ಸಮೀಪದಲ್ಲಿರುವ ಇ-ಚೌಪಾಲ್ ಕಿಯೋಸ್ಕ್‌ಗೆ ಭೇಟಿ ನೀಡಿ.", "ಸ್ಥಳೀಯ ಸಂಚಾಲಕರನ್ನು ಸಂಪರ್ಕಿಸಿ.", "ಇ-ಚೌಪಾಲ್ ಜಾಲದಲ್ಲಿ ನೋಂದಣಿ ಮಾಡಿ.", "ರೈತರು ಈ ಸೇವೆಗಳನ್ನು ಪಡೆಯಬಹುದು: ಮಾರುಕಟ್ಟೆ ಬೆಲೆ ಮಾಹಿತಿ, ಹವಾಮಾನ ಮುನ್ಸೂಚನೆ, ಕೃಷಿ ಸಲಹೆಗಳು.", "ರೈತರು ತಮ್ಮ ಬೆಳೆಗಳನ್ನು ಇ-ಚೌಪಾಲ್ ಖರೀದಿ ವ್ಯವಸ್ಥೆಯ ಮೂಲಕ ಮಾರಾಟ ಮಾಡಬಹುದು.", "ಪಾವತಿ ಮಾರುಕಟ್ಟೆ ದರದ ಪ್ರಕಾರ ನೇರವಾಗಿ ರೈತರಿಗೆ ನೀಡಲಾಗುತ್ತದೆ.", "ರೈತರು ಈ ಮಾರ್ಗಗಳ ಮೂಲಕ ಸೇವೆಗಳನ್ನು ಪಡೆಯಬಹುದು: ಗ್ರಾಮ ಇ-ಚೌಪಾಲ್ ಇಂಟರ್ನೆಟ್ ಕಿಯೋಸ್ಕ್‌ಗಳು, ಸ್ಥಳೀಯ ಸಂಚಾಲಕರು, ITC ಖರೀದಿ ಕೇಂದ್ರಗಳು, ITC ನಿರ್ವಹಿಸುವ ಗ್ರಾಮೀಣ ಸರಬರಾಜು ಸರಪಳಿ ಜಾಲ."]
69	34	ml	ഇ-ചൗപാൽ	ഇ-ചൗപാൽ എന്നത് ITC ലിമിറ്റഡ് ആരംഭിച്ച ഒരു ഡിജിറ്റൽ കാർഷിക പദ്ധതി ആണ്. ഇന്റർനെറ്റ് ಮತ್ತು ഡിജിറ്റൽ സാങ്കേതിക വിദ്യ ഉപയോഗിച്ച് കർഷകരെ നേരിട്ട് വിപണികളുമായി ബന്ധിപ്പിക്കുകയാണ് ഇതിന്റെ ലക്ഷ്യം.\n\nഈ പദ്ധതിയുടെ ഭാഗമായി ഗ്രാമങ്ങളിൽ ഇന്റർനെറ്റ് സൗകര്യമുള്ള കിയോസ്കുകൾ സ്ഥാപിക്കുന്നു. ഇതിലൂടെ കർഷകർക്ക് വിളകളുടെ വിപണി വില, കാലാവസ്ഥ പ്രവചനം, കൃഷി രീതികൾ, കാർഷിക ഇൻപുട്ടുകൾ എന്നിവയെക്കുറിച്ചുള്ള വിവരങ്ങൾ ലഭിക്കും.\n\nഇ-ചൗപാലിന്റെ പ്രധാന ലക്ഷ്യം ഇടനിലക്കാരെ കുറയ്ക്കുകയും കർഷകർക്ക് അവരുടെ വിളകൾ നേരിട്ട് കമ്പനികൾക്ക് നല്ല വിലയ്ക്ക് വിൽക്കാൻ സഹായിക്കുകയും ചെയ്യുന്നതാണ്.\n\nഈ പ്ലാറ്റ്ഫോം കാർഷിക അറിവ്, വിപണി വിവരം, സപ്ലൈ ചെയിൻ പിന്തുണ എന്നിവയും നൽകുന്നു, ഇതിലൂടെ കർഷകർക്ക് ആധുനിക കൃഷി രീതികൾ സ്വീകരിക്കാൻ കഴിയും.	["വിളകളുടെ വിപണി വിലകളെക്കുറിച്ചുള്ള തത്സമയ വിവരങ്ങൾ നൽകുന്നു.", "കർഷകർക്ക് ഇടനിലക്കാരില്ലാതെ നേരിട്ട് കമ്പനികൾക്ക് വിളകൾ വിൽക്കാൻ സഹായിക്കുന്നു.", "കാർഷിക വിപണികളിൽ കർഷകരുടെ ചർച്ചാ ശക്തി വർധിപ്പിക്കുന്നു.", "കാലാവസ്ഥ പ്രവചനവും കാർഷിക ഉപദേശങ്ങളും നൽകുന്നു.", "ഗുണമേന്മയുള്ള വിത്തുകൾ, വളങ്ങൾ, കാർഷിക ഇൻപുട്ടുകൾ വാങ്ങാൻ സഹായിക്കുന്നു.", "കാർഷിക വ്യാപാരത്തിലെ ഇടപാട് ചെലവും വൈകല്യവും കുറയ്ക്കുന്നു.", "വിളവില നിർണ്ണയത്തിൽ വ്യക്തത വർധിപ്പിക്കുന്നു.", "ഗ്രാമീണ കർഷകരിൽ ഡിജിറ്റൽ സാക്ഷരത പ്രോത്സാഹിപ്പിക്കുന്നു.", "മികച്ച കാർഷിക അറിവിലൂടെ വിള ഉൽപാദനക്ഷമത വർധിപ്പിക്കുന്നു."]	["അപേക്ഷകൻ ഇന്ത്യൻ കർഷകനായിരിക്കണം കൂടാതെ കാർഷിക പ്രവർത്തനങ്ങളിൽ ഏർപ്പെട്ടിരിക്കണം.", "ഇ-ചൗപാൽ കിയോസ്ക് ഉള്ള ഗ്രാമത്തിൽ താമസിക്കണം.", "കാർഷിക വിവരങ്ങൾ നേടാൻ അല്ലെങ്കിൽ ഈ പ്ലാറ്റ്ഫോം വഴി വിളകൾ വിൽക്കാൻ ആഗ്രഹിക്കുന്ന കർഷകർ പങ്കെടുക്കാം.", "കർഷകർ പ്രാദേശിക ഇ-ചൗപാൽ സഞ്ചാലകന്റെ അടുത്ത് രജിസ്റ്റർ ചെയ്യണം.", "ഇ-ചൗപാൽ വാങ്ങൽ സംവിധാനത്തിൽ ഉൾപ്പെട്ട വിളകൾ കൃഷി ചെയ്യുന്ന കർഷകർക്ക് പങ്കെടുക്കാം.", "അർഹരല്ലാത്തവർ: കാർഷിക പ്രവർത്തനങ്ങളിൽ ഏർപ്പെടാത്തവർ. ഇ-ചൗപാൽ സൗകര്യം ലഭ്യമല്ലാത്ത പ്രദേശങ്ങളിൽ താമസിക്കുന്ന കർഷകർ. പ്രാദേശിക ഇ-ചൗപാൽ നെറ്റ്വർക്കിൽ രജിസ്റ്റർ ചെയ്യാത്തവർ. ഇ-ചൗപാൽ സംവിധാനത്തിൽ ഉൾപ്പെടാത്ത വിളകൾ വിൽക്കുന്ന കർഷകർ."]	["നിങ്ങളുടെ ഗ്രാമത്തിന് സമീപമുള്ള ഇ-ചൗപാൽ കിയോസ്ക് സന്ദർശിക്കുക.", "പ്രാദേശിക സഞ്ചാലകനെ ബന്ധപ്പെടുക.", "ഇ-ചൗപാൽ നെറ്റ്വർക്കിൽ രജിസ്റ്റർ ചെയ്യുക.", "കർഷകർക്ക് ലഭ്യമായ സേവനങ്ങൾ: വിപണി വില വിവരം, കാലാവസ്ഥ പ്രവചനം, കാർഷിക ഉപദേശം.", "കർഷകർ അവരുടെ വിളകൾ ഇ-ചൗപാൽ വാങ്ങൽ സംവിധാനത്തിലൂടെ വിൽക്കാം.", "പേയ്മെന്റ് വിപണി നിരക്കനുസരിച്ച് നേരിട്ട് കർഷകർക്ക് നൽകപ്പെടുന്നു.", "കർഷകർക്ക് സേവനങ്ങൾ ലഭിക്കുന്ന മാർഗങ്ങൾ: ഗ്രാമ ഇ-ചൗപാൽ ഇന്റർനെറ്റ് കിയോസ്കുകൾ, പ്രാദേശിക സഞ്ചാലകൻ, ITC വാങ്ങൽ കേന്ദ്രങ്ങൾ, ITC നിയന്ത്രിക്കുന്ന ഗ്രാമീണ സപ്ലൈ ചെയിൻ നെറ്റ്വർക്ക്."]
70	34	or	ଇ-ଚୌପାଳ	ଇ-ଚୌପାଳ ହେଉଛି ITC Limited ଦ୍ୱାରା ଆରମ୍ଭ କରାଯାଇଥିବା ଏକ ଡିଜିଟାଲ କୃଷି ପ୍ରୟାସ। ଏହାର ଉଦ୍ଦେଶ୍ୟ ଇଣ୍ଟରନେଟ ଏବଂ ଡିଜିଟାଲ ପ୍ରଯୁକ୍ତିର ମାଧ୍ୟମରେ ଚାଷୀମାନଙ୍କୁ ସିଧାସଳଖ ବଜାର ସହିତ ଯୋଡ଼ିବା।\n\nଏହି ପ୍ରୟାସ ଅଧୀନରେ ଗ୍ରାମ ଅଞ୍ଚଳରେ ଇଣ୍ଟରନେଟ ସହିତ ସଜିତ କିଓସ୍କ ସ୍ଥାପନ କରାଯାଇଥାଏ। ଏଥିରେ ଚାଷୀମାନେ ପଣ୍ୟର ବଜାର ଦର, ପାଣିପାଗ ପୂର୍ବାନୁମାନ, ଚାଷ ପ୍ରଣାଳୀ ଏବଂ କୃଷି ଇନପୁଟ ବିଷୟରେ ସୂଚନା ପାଇପାରନ୍ତି।\n\nଇ-ଚୌପାଳର ମୁଖ୍ୟ ଉଦ୍ଦେଶ୍ୟ ମଧ୍ୟସ୍ଥମାନଙ୍କୁ କମାଇବା ଏବଂ ଚାଷୀମାନଙ୍କୁ ତାଙ୍କର ଉତ୍ପାଦନକୁ ସିଧାସଳଖ କମ୍ପାନୀଙ୍କୁ ଭଲ ଦରରେ ବିକ୍ରି କରିବାର ସୁଯୋଗ ଦେବା।\n\nଏହି ପ୍ଲାଟଫର୍ମ କୃଷି ଜ୍ଞାନ, ବଜାର ସୂଚନା ଏବଂ ସପ୍ଲାଇ ଚେନ ସମର୍ଥନ ମଧ୍ୟ ଦେଇଥାଏ, ଯାହା ଚାଷୀମାନଙ୍କୁ ଆଧୁନିକ କୃଷି ପ୍ରଣାଳୀ ଅପନାଇବାରେ ସାହାଯ୍ୟ କରେ।	["ପଣ୍ୟର ବଜାର ଦର ବିଷୟରେ ତତ୍କ୍ଷଣାତ ସୂଚନା ଦେଇଥାଏ।", "ଚାଷୀମାନଙ୍କୁ ମଧ୍ୟସ୍ଥ ବିନା ସିଧାସଳଖ କମ୍ପାନୀଙ୍କୁ ଉତ୍ପାଦନ ବିକ୍ରି କରିବାରେ ସାହାଯ୍ୟ କରେ।", "କୃଷି ବଜାରରେ ଚାଷୀମାନଙ୍କର ଆଲୋଚନା କ୍ଷମତା ବଢ଼ାଏ।", "ପାଣିପାଗ ପୂର୍ବାନୁମାନ ଏବଂ କୃଷି ପରାମର୍ଶ ଦେଇଥାଏ।", "ଗୁଣସ୍ତରୀୟ ବିଆ, ସର ଏବଂ କୃଷି ଇନପୁଟ କିଣିବାରେ ସାହାଯ୍ୟ କରେ।", "କୃଷି ବ୍ୟବସାୟରେ ଲେନଦେନ ଖର୍ଚ୍ଚ ଏବଂ ବିଳମ୍ବ କମାଏ।", "ପଣ୍ୟ ଦର ନିର୍ଣ୍ଣୟରେ ପାରଦର୍ଶିତା ବଢ଼ାଏ।", "ଗ୍ରାମୀଣ ଚାଷୀମାନଙ୍କ ମଧ୍ୟରେ ଡିଜିଟାଲ ସାକ୍ଷରତାକୁ ପ୍ରୋତ୍ସାହନ ଦେଇଥାଏ।", "ଭଲ କୃଷି ଜ୍ଞାନ ଦ୍ୱାରା ଚାଷ ଉତ୍ପାଦନକ୍ଷମତା ବଢ଼ାଏ।"]	["ଆବେଦକ ଭାରତୀୟ ଚାଷୀ ହେବା ଆବଶ୍ୟକ ଏବଂ କୃଷି କାର୍ଯ୍ୟରେ ଲିପ୍ତ ହେବା ଦରକାର।", "ସେହି ଗ୍ରାମରେ ବସବାସ କରିବା ଦରକାର ଯେଉଁଠାରେ ଇ-ଚୌପାଳ କିଓସ୍କ ଉପଲବ୍ଧ ଅଛି।", "କୃଷି ସୂଚନା ପାଇବାକୁ କିମ୍ବା ଏହି ପ୍ଲାଟଫର୍ମ ମାଧ୍ୟମରେ ଉତ୍ପାଦନ ବିକ୍ରି କରିବାକୁ ଇଚ୍ଛୁକ ଚାଷୀମାନେ ଅଂଶଗ୍ରହଣ କରିପାରିବେ।", "ଚାଷୀମାନେ ସ୍ଥାନୀୟ ଇ-ଚୌପାଳ ସଞ୍ଚାଳକଙ୍କ ସହିତ ନିବନ୍ଧନ କରିବା ଆବଶ୍ୟକ।", "ଇ-ଚୌପାଳ କ୍ରୟ ପ୍ରଣାଳୀ ଅଧୀନରେ ଥିବା ପଣ୍ୟ ଚାଷ କରୁଥିବା ଚାଷୀମାନେ ଅଂଶ ନେଇପାରିବେ।", "ଅଯୋଗ୍ୟ ଶ୍ରେଣୀ: କୃଷି କାର୍ଯ୍ୟରେ ଲିପ୍ତ ନଥିବା ବ୍ୟକ୍ତିମାନେ। ଯେଉଁଠାରେ ଇ-ଚୌପାଳ ସୁବିଧା ନାହିଁ ସେହି ଅଞ୍ଚଳର ଚାଷୀମାନେ। ସ୍ଥାନୀୟ ଇ-ଚୌପାଳ ନେଟୱର୍କରେ ନିବନ୍ଧନ ନକରିଥିବା ବ୍ୟକ୍ତିମାନେ। ଇ-ଚୌପାଳ ପ୍ରଣାଳୀରେ ନଥିବା ପଣ୍ୟ ବିକ୍ରି କରୁଥିବା ଚାଷୀମାନେ।"]	["ନିକଟସ୍ଥ ଇ-ଚୌପାଳ କିଓସ୍କକୁ ଯାଆନ୍ତୁ।", "ସ୍ଥାନୀୟ ସଞ୍ଚାଳକଙ୍କ ସହିତ ସମ୍ପର୍କ କରନ୍ତୁ।", "ଇ-ଚୌପାଳ ନେଟୱର୍କରେ ନିବନ୍ଧନ କରନ୍ତୁ।", "ଚାଷୀମାନେ ଏହି ସେବାଗୁଡ଼ିକ ପାଇପାରିବେ: ବଜାର ଦର ସୂଚନା, ପାଣିପାଗ ପୂର୍ବାନୁମାନ, କୃଷି ପରାମର୍ଶ।", "ଚାଷୀମାନେ ତାଙ୍କର ପଣ୍ୟକୁ ଇ-ଚୌପାଳ କ୍ରୟ ପ୍ରଣାଳୀ ମାଧ୍ୟମରେ ବିକ୍ରି କରିପାରିବେ।", "ପେମେଣ୍ଟ ବଜାର ଦର ଅନୁସାରେ ସିଧାସଳଖ ଚାଷୀଙ୍କୁ ଦିଆଯାଏ।", "ସେବା ପାଇବା ଉପାୟ: ଗ୍ରାମ ଇ-ଚୌପାଳ କିଓସ୍କ, ସ୍ଥାନୀୟ ସଞ୍ଚାଳକ, ITC କ୍ରୟ କେନ୍ଦ୍ର, ITC ପରିଚାଳିତ ଗ୍ରାମୀଣ ସପ୍ଲାଇ ଚେନ ନେଟୱର୍କ।"]
71	34	bn	ই-চৌপাল	ই-চৌপাল হলো ITC Limited দ্বারা চালু করা একটি ডিজিটাল কৃষি উদ্যোগ যার লক্ষ্য ইন্টারনেট এবং ডিজিটাল প্রযুক্তির মাধ্যমে কৃষকদের সরাসরি বাজারের সাথে সংযুক্ত করা।\n\nএই উদ্যোগের অধীনে গ্রামীণ এলাকায় ইন্টারনেট সুবিধাসহ কিয়স্ক স্থাপন করা হয়। এর মাধ্যমে কৃষকরা ফসলের বাজার মূল্য, আবহাওয়ার পূর্বাভাস, কৃষি পদ্ধতি এবং কৃষি ইনপুট সম্পর্কে তথ্য পেতে পারেন।\n\nই-চৌপালের প্রধান লক্ষ্য হলো মধ্যস্বত্বভোগীদের কমানো এবং কৃষকদের তাদের উৎপাদন সরাসরি কোম্পানির কাছে ভালো দামে বিক্রি করতে সাহায্য করা।\n\nএই প্ল্যাটফর্ম কৃষি জ্ঞান, বাজার তথ্য এবং সরবরাহ শৃঙ্খল সহায়তাও প্রদান করে, যা কৃষকদের আধুনিক কৃষি প্রযুক্তি গ্রহণে সাহায্য করে।	["ফসলের বাজার দামের রিয়েল-টাইম তথ্য প্রদান করে।", "কৃষকদের মধ্যস্বত্বভোগী ছাড়া সরাসরি কোম্পানির কাছে ফসল বিক্রি করতে সাহায্য করে।", "কৃষি বাজারে কৃষকদের দর কষাকষির ক্ষমতা বৃদ্ধি করে।", "আবহাওয়ার পূর্বাভাস এবং কৃষি পরামর্শ প্রদান করে।", "উন্নত মানের বীজ, সার এবং কৃষি উপকরণ কিনতে সাহায্য করে।", "কৃষি বাণিজ্যে লেনদেন খরচ এবং বিলম্ব কমায়।", "ফসলের দাম নির্ধারণে স্বচ্ছতা বৃদ্ধি করে।", "গ্রামীণ কৃষকদের মধ্যে ডিজিটাল সাক্ষরতা বাড়ায়।", "উন্নত কৃষি জ্ঞানের মাধ্যমে উৎপাদনশীলতা বৃদ্ধি করে।"]	["আবেদনকারীকে ভারতীয় কৃষক হতে হবে এবং কৃষি কার্যক্রমে যুক্ত থাকতে হবে।", "যে গ্রামে ই-চৌপাল কিয়স্ক রয়েছে সেখানে বসবাস করতে হবে।", "যে কৃষকরা কৃষি তথ্য পেতে চান বা এই প্ল্যাটফর্মের মাধ্যমে ফসল বিক্রি করতে চান তারা অংশ নিতে পারবেন।", "কৃষকদের স্থানীয় ই-চৌপাল পরিচালকের কাছে নিবন্ধন করতে হবে।", "ই-চৌপাল ক্রয় ব্যবস্থার অন্তর্ভুক্ত ফসল উৎপাদনকারী কৃষকরা অংশ নিতে পারবেন।", "অযোগ্য বিভাগ: যারা কৃষি কার্যক্রমে যুক্ত নন। যেখানে ই-চৌপাল সুবিধা নেই এমন এলাকার কৃষকরা। স্থানীয় ই-চৌপাল নেটওয়ার্কে নিবন্ধন করেননি এমন ব্যক্তিরা। ই-চৌপাল ব্যবস্থায় অন্তর্ভুক্ত নয় এমন ফসল বিক্রি করা কৃষকরা।"]	["নিকটবর্তী ই-চৌপাল কিয়স্কে যান।", "স্থানীয় পরিচালকের সাথে যোগাযোগ করুন।", "ই-চৌপাল নেটওয়ার্কে নিবন্ধন করুন।", "কৃষকরা এই পরিষেবাগুলি পেতে পারেন: বাজার মূল্য তথ্য, আবহাওয়ার পূর্বাভাস, কৃষি পরামর্শ।", "কৃষকরা তাদের ফসল ই-চৌপাল ক্রয় ব্যবস্থার মাধ্যমে বিক্রি করতে পারেন।", "বাজার দরের ভিত্তিতে অর্থ সরাসরি কৃষকদের প্রদান করা হয়।", "সেবা পাওয়ার উপায়: গ্রাম ই-চৌপাল ইন্টারনেট কিয়স্ক, স্থানীয় পরিচালক, ITC ক্রয় কেন্দ্র, ITC পরিচালিত গ্রামীণ সরবরাহ শৃঙ্খল নেটওয়ার্ক।"]
72	34	mr	ई-चौपाल	ई-चौपाल ही आयटीसी लिमिटेडने सुरू केलेली एक डिजिटल कृषी उपक्रम आहे ज्याचा उद्देश इंटरनेट आणि डिजिटल तंत्रज्ञानाच्या मदतीने शेतकऱ्यांना थेट बाजारपेठेशी जोडणे आहे.\n\nया उपक्रमांतर्गत ग्रामीण भागात इंटरनेट-सक्षम कियोस्क उभारले जातात, ज्यामुळे शेतकऱ्यांना पिकांच्या बाजारभावांची माहिती, हवामानाचा अंदाज, शेती पद्धती आणि कृषी इनपुट्स याबद्दल माहिती मिळते.\n\nई-चौपालचा मुख्य उद्देश मध्यस्थांना कमी करणे आणि शेतकऱ्यांना त्यांची शेतीमाल थेट कंपन्यांना चांगल्या किमतीत विकण्यास सक्षम करणे आहे, ज्यामुळे त्यांचे उत्पन्न आणि निर्णयक्षमता सुधारते.\n\nहे व्यासपीठ शेतकऱ्यांना कृषी ज्ञान, बाजार माहिती आणि पुरवठा साखळीचे समर्थन देखील देते, ज्यामुळे ते आधुनिक शेती तंत्रज्ञान स्वीकारू शकतात.	["पिकांच्या बाजारभावांची रिअल-टाइम माहिती उपलब्ध करून देते.", "शेतकऱ्यांना मध्यस्थांशिवाय थेट कंपन्यांना माल विकण्यास मदत करते.", "कृषी बाजारपेठेत शेतकऱ्यांची सौदेबाजी क्षमता वाढवते.", "हवामानाचा अंदाज आणि शेतीसंबंधित मार्गदर्शन देते.", "उत्तम दर्जाचे बियाणे, खते आणि कृषी इनपुट खरेदी करण्यास मदत करते.", "कृषी व्यापारातील व्यवहार खर्च आणि विलंब कमी करते.", "पिकांच्या किमतींमध्ये पारदर्शकता वाढवते.", "ग्रामीण शेतकऱ्यांमध्ये डिजिटल साक्षरतेला प्रोत्साहन देते.", "चांगल्या कृषी ज्ञानामुळे शेती उत्पादनक्षमता वाढवते."]	["अर्जदार भारतीय शेतकरी असावा आणि शेतीशी संबंधित कामात गुंतलेला असावा.", "अर्जदार अशा गावात राहत असावा जिथे ई-चौपाल कियोस्क उपलब्ध आहे.", "जे शेतकरी कृषी माहिती मिळवू इच्छितात किंवा या प्लॅटफॉर्मद्वारे आपला माल विकू इच्छितात ते सहभागी होऊ शकतात.", "शेतकऱ्यांनी स्थानिक ई-चौपाल संचालक (संचालक) यांच्याकडे नोंदणी करणे आवश्यक आहे.", "ई-चौपाल खरेदी प्रणालीद्वारे समर्थित पिके घेणारे शेतकरी सहभागी होऊ शकतात.", "अपात्र श्रेणी: शेतीशी संबंधित नसलेले व्यक्ती. ज्या भागात ई-चौपाल सुविधा उपलब्ध नाहीत अशा भागातील शेतकरी. स्थानिक ई-चौपाल नेटवर्कमध्ये नोंदणी नसलेले व्यक्ती. ई-चौपाल प्रणालीद्वारे हाताळली न जाणारी पिके विकणारे शेतकरी."]	["गावातील जवळच्या ई-चौपाल कियोस्कला भेट द्या.", "स्थानिक संचालक (कियोस्क चालवणारा प्रशिक्षित शेतकरी) यांच्याशी संपर्क साधा.", "ई-चौपाल नेटवर्कमध्ये नोंदणी करा.", "शेतकरी पुढील सेवा वापरू शकतात: बाजारभावांची माहिती, हवामानाचा अंदाज, शेतीसंबंधित सल्ला.", "शेतकरी त्यांचा शेतीमाल ई-चौपाल खरेदी प्रणालीद्वारे विकू शकतात.", "भरणा बाजारभावानुसार थेट शेतकऱ्याच्या खात्यात केला जातो.", "शेतकरी पुढील माध्यमांतून ई-चौपाल सेवा वापरू शकतात: गावातील ई-चौपाल इंटरनेट कियोस्क, स्थानिक संचालक (गाव समन्वयक), ई-चौपालशी जोडलेले आयटीसी खरेदी केंद्र, आयटीसीद्वारे व्यवस्थापित ग्रामीण पुरवठा साखळी नेटवर्क."]
42	25	en	Pradhan Mantri Kisan Samman Nidhi (PM-KISAN)	Pradhan Mantri Kisan Samman Nidhi (PM-KISAN) is a Central Sector Scheme of the Government of India that provides income support to landholding farmer families across the country. Under this scheme, eligible farmers receive ₹6,000 per year to help them meet agricultural and household expenses. The amount is transferred directly into the farmer’s bank account through Direct Benefit Transfer (DBT).\n\nThe scheme aims to support small and marginal farmers financially so they can buy seeds, fertilizers, and other agricultural inputs without depending on informal loans.	["Financial assistance of ₹6,000 per year to eligible farmer families.", "Amount is paid in 3 installments of ₹2,000 each every four months.", "Money is transferred directly to bank accounts via DBT (Direct Benefit Transfer).", "Helps farmers purchase seeds, fertilizers, and agricultural inputs.", "Reduces farmers’ dependence on informal loans or moneylenders.", "Supports small and marginal farmers’ income stability.", "Nationwide coverage for crores of farmer families across India."]	["Applicant must be an Indian citizen.", "Must be a landholding farmer family with cultivable agricultural land.", "Land records must be registered in the farmer’s name in state/UT records.", "Aadhaar card must be linked with the application.", "Bank account must be linked with Aadhaar for DBT payment.", "e-KYC completion is mandatory to receive installments.", "Both small and large landholding farmers can apply (earlier only small and marginal farmers were eligible).", "Not Eligible - Institutional landholders, Serving or retired government officers/employees of Central or State Government (except Group D / Multi-Tasking Staff / Class IV employees), Income tax payers, Former or present constitutional post holders (President, Ministers, MPs, MLAs, etc.),  Professionals registered with professional bodies, such as:  Doctors/ Engineers/ Lawyers/ Chartered/ Accountants/ Architects, Individuals receiving pension above ₹10,000 per month (except lower category employees), Individuals owning large institutional agricultural lands. "]	["Visit the official portal: https://pmkisan.gov.in", "Click on “New Farmer Registration.”", "Enter Aadhaar number and captcha code.", "Fill the registration form with details:  Name, State / district / village, Land details, Bank account details.", "Upload required documents (Aadhaar, land record, bank details).", "Submit the application online.", "Complete e-KYC verification.", "After verification by authorities, the farmer is added to the beneficiary list and installments start.", "Farmers can also apply through Common Service Centres (CSC) or local agriculture offices."]
74	35	hi	प्रधान मंत्री किसान सम्मान निधि (PM-KISAN)	प्रधान मंत्री किसान सम्मान निधि (PM-KISAN) भारत सरकार की एक केंद्रीय क्षेत्र योजना है जो देश भर के भूमिधारक किसान परिवारों को आय सहायता प्रदान करती है। इस योजना के तहत पात्र किसानों को कृषि और घरेलू खर्चों को पूरा करने में सहायता के लिए प्रति वर्ष ₹6,000 प्रदान किए जाते हैं। यह राशि डायरेक्ट बेनिफिट ट्रांसफर (DBT) के माध्यम से सीधे किसान के बैंक खाते में भेजी जाती है।\n\nइस योजना का उद्देश्य छोटे और सीमांत किसानों को वित्तीय सहायता प्रदान करना है ताकि वे बिना अनौपचारिक ऋण पर निर्भर हुए बीज, उर्वरक और अन्य कृषि इनपुट खरीद सकें।	["पात्र किसान परिवारों को प्रति वर्ष ₹6,000 की वित्तीय सहायता।", "राशि हर चार महीने में ₹2,000 की 3 किस्तों में दी जाती है।", "पैसा सीधे DBT (Direct Benefit Transfer) के माध्यम से बैंक खाते में भेजा जाता है।", "किसानों को बीज, उर्वरक और अन्य कृषि इनपुट खरीदने में मदद करता है।", "अनौपचारिक ऋण या साहूकारों पर किसानों की निर्भरता कम करता है।", "छोटे और सीमांत किसानों की आय स्थिरता को समर्थन देता है।", "भारत भर में करोड़ों किसान परिवारों को लाभ प्रदान करता है।"]	["आवेदक भारत का नागरिक होना चाहिए।", "कृषि योग्य भूमि रखने वाला किसान परिवार होना चाहिए।", "भूमि का रिकॉर्ड किसान के नाम पर राज्य या केंद्र शासित प्रदेश के रिकॉर्ड में दर्ज होना चाहिए।", "आधार कार्ड आवेदन के साथ लिंक होना चाहिए।", "DBT भुगतान के लिए बैंक खाता आधार से लिंक होना चाहिए।", "किस्त प्राप्त करने के लिए e-KYC पूरा करना अनिवार्य है।", "छोटे और बड़े दोनों प्रकार के भूमि धारक किसान आवेदन कर सकते हैं।", "अपात्र श्रेणी - संस्थागत भूमि धारक, केंद्र या राज्य सरकार के कार्यरत या सेवानिवृत्त अधिकारी/कर्मचारी (Group D / Multi-Tasking Staff / Class IV को छोड़कर), आयकर देने वाले व्यक्ति, वर्तमान या पूर्व संवैधानिक पदाधिकारी (राष्ट्रपति, मंत्री, सांसद, विधायक आदि), पेशेवर निकायों में पंजीकृत पेशेवर जैसे डॉक्टर, इंजीनियर, वकील, चार्टर्ड अकाउंटेंट, आर्किटेक्ट, ₹10,000 से अधिक मासिक पेंशन प्राप्त करने वाले व्यक्ति (निम्न श्रेणी कर्मचारियों को छोड़कर), बड़े संस्थागत कृषि भूमि के मालिक व्यक्ति।"]	["आधिकारिक पोर्टल पर जाएँ: https://pmkisan.gov.in", "“New Farmer Registration” पर क्लिक करें।", "आधार नंबर और कैप्चा कोड दर्ज करें।", "पंजीकरण फॉर्म भरें: नाम, राज्य / जिला / गाँव, भूमि विवरण, बैंक खाता विवरण।", "आवश्यक दस्तावेज अपलोड करें (आधार, भूमि रिकॉर्ड, बैंक विवरण)।", "ऑनलाइन आवेदन जमा करें।", "e-KYC सत्यापन पूरा करें।", "अधिकारियों द्वारा सत्यापन के बाद किसान लाभार्थी सूची में जोड़ दिया जाता है और किस्तें शुरू हो जाती हैं।", "किसान Common Service Centres (CSC) या स्थानीय कृषि कार्यालयों के माध्यम से भी आवेदन कर सकते हैं।"]
75	35	mr	प्रधानमंत्री किसान सन्मान निधी (PM-KISAN)	प्रधानमंत्री किसान सन्मान निधी (PM-KISAN) ही भारत सरकारची एक केंद्रीय क्षेत्र योजना आहे जी देशभरातील भूमिधारक शेतकरी कुटुंबांना आर्थिक मदत प्रदान करते. या योजनेअंतर्गत पात्र शेतकऱ्यांना शेती आणि घरगुती खर्च भागवण्यासाठी दरवर्षी ₹6,000 दिले जातात. ही रक्कम डायरेक्ट बेनिफिट ट्रान्सफर (DBT) द्वारे थेट शेतकऱ्यांच्या बँक खात्यात जमा केली जाते.\n\nया योजनेचा उद्देश लहान आणि सीमांत शेतकऱ्यांना आर्थिक सहाय्य देणे आहे, ज्यामुळे ते बियाणे, खत आणि इतर कृषी इनपुट खरेदी करू शकतील आणि अनौपचारिक कर्जावर अवलंबून राहावे लागणार नाही.	["पात्र शेतकरी कुटुंबांना दरवर्षी ₹6,000 ची आर्थिक मदत दिली जाते.", "ही रक्कम दर चार महिन्यांनी ₹2,000 च्या तीन हप्त्यांमध्ये दिली जाते.", "रक्कम DBT (Direct Benefit Transfer) द्वारे थेट बँक खात्यात जमा केली जाते.", "शेतकऱ्यांना बियाणे, खते आणि कृषी इनपुट खरेदी करण्यास मदत होते.", "अनौपचारिक कर्ज किंवा सावकारांवर शेतकऱ्यांचे अवलंबित्व कमी होते.", "लहान आणि सीमांत शेतकऱ्यांच्या उत्पन्न स्थिरतेस मदत होते.", "भारतभरातील कोट्यवधी शेतकरी कुटुंबांना या योजनेचा लाभ मिळतो."]	["अर्जदार भारतीय नागरिक असावा.", "शेतीयोग्य जमीन असलेले शेतकरी कुटुंब असावे.", "जमिनीचे नोंद राज्य किंवा केंद्रशासित प्रदेशाच्या नोंदीमध्ये शेतकऱ्याच्या नावावर असावी.", "आधार कार्ड अर्जासोबत जोडलेले असणे आवश्यक आहे.", "DBT साठी बँक खाते आधारशी जोडलेले असणे आवश्यक आहे.", "हप्ते मिळवण्यासाठी e-KYC पूर्ण करणे बंधनकारक आहे.", "लहान आणि मोठे दोन्ही प्रकारचे जमीनधारक शेतकरी अर्ज करू शकतात.", "अपात्र श्रेणी - संस्थात्मक जमीनधारक, केंद्र किंवा राज्य सरकारचे कार्यरत किंवा निवृत्त अधिकारी/कर्मचारी (Group D / Multi-Tasking Staff / Class IV वगळता), आयकर भरणारे नागरिक, विद्यमान किंवा माजी घटनात्मक पदाधिकारी (राष्ट्रपती, मंत्री, खासदार, आमदार इ.), व्यावसायिक संस्थांमध्ये नोंदणीकृत व्यावसायिक जसे डॉक्टर, अभियंते, वकील, चार्टर्ड अकाउंटंट, आर्किटेक्ट, ₹10,000 पेक्षा जास्त मासिक पेन्शन घेणारे व्यक्ती (निम्न श्रेणी कर्मचारी वगळता), मोठ्या संस्थात्मक कृषी जमिनीचे मालक."]	["अधिकृत पोर्टलला भेट द्या: https://pmkisan.gov.in", "“New Farmer Registration” वर क्लिक करा.", "आधार क्रमांक आणि कॅप्चा कोड प्रविष्ट करा.", "नोंदणी फॉर्म भरा: नाव, राज्य / जिल्हा / गाव, जमिनीचे तपशील, बँक खात्याची माहिती.", "आवश्यक कागदपत्रे अपलोड करा (आधार, जमीन नोंद, बँक तपशील).", "ऑनलाइन अर्ज सादर करा.", "e-KYC पडताळणी पूर्ण करा.", "अधिकाऱ्यांकडून पडताळणी झाल्यानंतर शेतकऱ्याचे नाव लाभार्थी यादीत समाविष्ट केले जाते आणि हप्ते सुरू होतात.", "शेतकरी Common Service Centres (CSC) किंवा स्थानिक कृषी कार्यालयांमार्फतही अर्ज करू शकतात."]
76	35	ta	பிரதமர் கிசான் சம்மான் நிதி (PM-KISAN)	பிரதமர் கிசான் சம்மான் நிதி (PM-KISAN) என்பது இந்திய அரசின் மத்திய துறை திட்டமாகும். இது நாடு முழுவதும் நிலம் கொண்ட விவசாயக் குடும்பங்களுக்கு வருமான ஆதரவு வழங்குகிறது. இந்த திட்டத்தின் கீழ் தகுதியான விவசாயிகளுக்கு வருடத்திற்கு ₹6,000 வழங்கப்படுகிறது, இது அவர்களின் வேளாண்மை மற்றும் குடும்ப செலவுகளை சந்திக்க உதவுகிறது. இந்த தொகை நேரடி நன்மை பரிமாற்றம் (DBT) மூலம் நேரடியாக விவசாயியின் வங்கி கணக்கில் செலுத்தப்படுகிறது.\n\nஇந்த திட்டத்தின் நோக்கம் சிறு மற்றும் குறைந்த நிலம் கொண்ட விவசாயிகளுக்கு நிதி ஆதரவு வழங்குவது ஆகும், இதனால் அவர்கள் விதைகள், உரங்கள் மற்றும் பிற வேளாண் உள்ளீடுகளை வாங்க அனுமதிக்கிறது மற்றும் அந்நிய கடன்களின்மீது சார்ந்திருப்பதை குறைக்கிறது.	["தகுதியான விவசாயக் குடும்பங்களுக்கு வருடத்திற்கு ₹6,000 நிதி உதவி வழங்கப்படுகிறது.", "இந்த தொகை நான்கு மாதங்களுக்கு ஒருமுறை ₹2,000 வீதம் மூன்று தவணைகளாக வழங்கப்படுகிறது.", "பணம் DBT (Direct Benefit Transfer) மூலம் நேரடியாக வங்கி கணக்கில் செலுத்தப்படுகிறது.", "விவசாயிகள் விதைகள், உரங்கள் மற்றும் வேளாண் உள்ளீடுகளை வாங்க உதவுகிறது.", "சட்டவிரோத கடன்கள் அல்லது பணக்காரர்களின் மீது விவசாயிகளின் சார்பை குறைக்கிறது.", "சிறு மற்றும் குறைந்த நிலம் கொண்ட விவசாயிகளின் வருமான நிலைத்தன்மையை ஆதரிக்கிறது.", "இந்தியாவில் கோடிக்கணக்கான விவசாயக் குடும்பங்களுக்கு நாடு முழுவதும் பயன்படுகிறது."]	["விண்ணப்பதாரர் இந்திய குடிமகனாக இருக்க வேண்டும்.", "விவசாய நிலம் கொண்ட விவசாயக் குடும்பமாக இருக்க வேண்டும்.", "நில பதிவு மாநிலம் அல்லது யூனியன் பிரதேச பதிவுகளில் விவசாயியின் பெயரில் இருக்க வேண்டும்.", "ஆதார் அட்டை விண்ணப்பத்துடன் இணைக்கப்பட்டிருக்க வேண்டும்.", "DBT பணம் பெற வங்கி கணக்கு ஆதாருடன் இணைக்கப்பட்டிருக்க வேண்டும்.", "தவணைகளை பெற e-KYC முடித்திருக்க வேண்டும்.", "சிறிய மற்றும் பெரிய நிலம் கொண்ட விவசாயிகள் இருவரும் விண்ணப்பிக்கலாம்.", "தகுதி இல்லை - நிறுவன நில உரிமையாளர்கள், மத்திய அல்லது மாநில அரசு பணியாளர்கள் அல்லது ஓய்வு பெற்ற அதிகாரிகள் (Group D / Multi-Tasking Staff / Class IV தவிர), வருமான வரி செலுத்துவோர், முன்னாள் அல்லது தற்போதைய அரசியலமைப்பு பதவியாளர்கள் (ராஷ்டிரபதி, அமைச்சர்கள், எம்.பி., எம்.எல்.ஏ. முதலியோர்), தொழில்முறை அமைப்புகளில் பதிவு செய்யப்பட்டவர்கள் (மருத்துவர், பொறியாளர், வழக்கறிஞர், சார்ட்டர்ட் அக்கவுண்டெண்ட், ஆர்கிடெக்ட்), மாதம் ₹10,000 க்கும் அதிகமாக ஓய்வூதியம் பெறுபவர்கள் (குறைந்த நிலை ஊழியர்கள் தவிர), பெரிய நிறுவன வேளாண் நிலம் கொண்டவர்கள்."]	["அதிகாரப்பூர்வ இணையதளத்தை பார்வையிடவும்: https://pmkisan.gov.in", "“New Farmer Registration” என்பதைக் கிளிக் செய்யவும்.", "ஆதார் எண் மற்றும் கேப்சா குறியீட்டை உள்ளிடவும்.", "பதிவு படிவத்தை நிரப்பவும்: பெயர், மாநிலம் / மாவட்டம் / கிராமம், நில விவரங்கள், வங்கி கணக்கு விவரங்கள்.", "தேவையான ஆவணங்களை பதிவேற்றவும் (ஆதார், நில பதிவுகள், வங்கி விவரங்கள்).", "ஆன்லைன் விண்ணப்பத்தை சமர்ப்பிக்கவும்.", "e-KYC சரிபார்ப்பை முடிக்கவும்.", "அதிகாரிகள் சரிபார்த்த பிறகு விவசாயி பயனாளி பட்டியலில் சேர்க்கப்படுவார் மற்றும் தவணைகள் தொடங்கும்.", "விவசாயிகள் Common Service Centres (CSC) அல்லது உள்ளூர் வேளாண் அலுவலகங்கள் மூலமும் விண்ணப்பிக்கலாம்."]
77	35	te	ప్రధాన మంత్రి కిసాన్ సమ్మాన్ నిధి (PM-KISAN)	ప్రధాన మంత్రి కిసాన్ సమ్మాన్ నిధి (PM-KISAN) భారత ప్రభుత్వ కేంద్ర రంగ పథకం. ఇది దేశవ్యాప్తంగా భూమి కలిగిన రైతు కుటుంబాలకు ఆదాయ మద్దతు అందిస్తుంది. ఈ పథకం కింద అర్హత కలిగిన రైతులకు సంవత్సరానికి ₹6,000 అందించబడుతుంది, ఇది వ్యవసాయ మరియు గృహ ఖర్చులను నిర్వహించేందుకు సహాయపడుతుంది. ఈ మొత్తం డైరెక్ట్ బెనిఫిట్ ట్రాన్స్‌ఫర్ (DBT) ద్వారా నేరుగా రైతు బ్యాంక్ ఖాతాలో జమ అవుతుంది.\n\nఈ పథకం చిన్న మరియు సన్న రైతులకు ఆర్థిక సహాయం అందించడం లక్ష్యంగా పెట్టుకుంది, తద్వారా వారు విత్తనాలు, ఎరువులు మరియు ఇతర వ్యవసాయ ఇన్‌పుట్‌లను కొనుగోలు చేయగలరు మరియు అనధికారిక రుణాలపై ఆధారపడాల్సిన అవసరం తగ్గుతుంది.	["అర్హత కలిగిన రైతు కుటుంబాలకు సంవత్సరానికి ₹6,000 ఆర్థిక సహాయం.", "ఈ మొత్తం ప్రతి నాలుగు నెలలకు ₹2,000 చొప్పున మూడు విడతలుగా చెల్లించబడుతుంది.", "డబ్బు DBT (Direct Benefit Transfer) ద్వారా నేరుగా బ్యాంక్ ఖాతాలో జమ అవుతుంది.", "రైతులు విత్తనాలు, ఎరువులు మరియు వ్యవసాయ ఇన్‌పుట్‌లు కొనుగోలు చేయడానికి సహాయపడుతుంది.", "అనధికారిక రుణదాతలపై రైతుల ఆధారాన్ని తగ్గిస్తుంది.", "చిన్న మరియు సన్న రైతుల ఆదాయ స్థిరత్వాన్ని పెంచుతుంది.", "దేశవ్యాప్తంగా కోట్లాది రైతు కుటుంబాలకు ప్రయోజనం అందిస్తుంది."]	["అభ్యర్థి భారతీయ పౌరుడు కావాలి.", "వ్యవసాయ భూమి కలిగిన రైతు కుటుంబం కావాలి.", "భూమి రికార్డులు రాష్ట్రం లేదా కేంద్రపాలిత ప్రాంతపు రికార్డుల్లో రైతు పేరుతో ఉండాలి.", "ఆధార్ కార్డు దరఖాస్తుతో లింక్ చేయాలి.", "DBT చెల్లింపుల కోసం బ్యాంక్ ఖాతా ఆధార్‌తో లింక్ చేయాలి.", "విడతలను పొందడానికి e-KYC పూర్తి చేయాలి.", "చిన్న మరియు పెద్ద భూమి కలిగిన రైతులు ఇద్దరూ దరఖాస్తు చేయవచ్చు.", "అర్హులు కానివారు - సంస్థాగత భూమి యజమానులు, కేంద్ర లేదా రాష్ట్ర ప్రభుత్వ ఉద్యోగులు లేదా పదవీ విరమణ చేసిన అధికారులు (Group D / Multi-Tasking Staff / Class IV తప్ప), ఆదాయపు పన్ను చెల్లించే వ్యక్తులు, ప్రస్తుత లేదా మాజీ రాజ్యాంగ పదవిదారులు (రాష్ట్రపతి, మంత్రులు, ఎంపీలు, ఎమ్మెల్యేలు మొదలైనవి), వృత్తి సంస్థల్లో నమోదు చేసిన నిపుణులు (డాక్టర్లు, ఇంజినీర్లు, న్యాయవాదులు, చార్టర్డ్ అకౌంటెంట్లు, ఆర్కిటెక్ట్లు), నెలకు ₹10,000 కంటే ఎక్కువ పెన్షన్ పొందేవారు (తక్కువ స్థాయి ఉద్యోగులు తప్ప), పెద్ద సంస్థాగత వ్యవసాయ భూమి యజమానులు."]	["అధికారిక వెబ్‌సైట్‌ను సందర్శించండి: https://pmkisan.gov.in", "“New Farmer Registration” పై క్లిక్ చేయండి.", "ఆధార్ నంబర్ మరియు క్యాప్చా కోడ్ నమోదు చేయండి.", "రిజిస్ట్రేషన్ ఫారమ్ నింపండి: పేరు, రాష్ట్రం / జిల్లా / గ్రామం, భూమి వివరాలు, బ్యాంక్ ఖాతా వివరాలు.", "అవసరమైన పత్రాలు అప్‌లోడ్ చేయండి (ఆధార్, భూమి రికార్డు, బ్యాంక్ వివరాలు).", "ఆన్‌లైన్ దరఖాస్తును సమర్పించండి.", "e-KYC ధృవీకరణ పూర్తి చేయండి.", "అధికారుల ధృవీకరణ తరువాత రైతు లబ్ధిదారుల జాబితాలో చేరుతాడు మరియు విడతలు ప్రారంభమవుతాయి.", "రైతులు Common Service Centres (CSC) లేదా స్థానిక వ్యవసాయ కార్యాలయాల ద్వారా కూడా దరఖాస్తు చేయవచ్చు."]
78	35	pa	ਪ੍ਰਧਾਨ ਮੰਤਰੀ ਕਿਸਾਨ ਸਮਮਾਨ ਨਿਧੀ (PM-KISAN)	ਪ੍ਰਧਾਨ ਮੰਤਰੀ ਕਿਸਾਨ ਸਮਮਾਨ ਨਿਧੀ (PM-KISAN) ਭਾਰਤ ਸਰਕਾਰ ਦੀ ਇੱਕ ਕੇਂਦਰੀ ਖੇਤਰ ਯੋਜਨਾ ਹੈ ਜੋ ਦੇਸ਼ ਭਰ ਦੇ ਜ਼ਮੀਨ ਰੱਖਣ ਵਾਲੇ ਕਿਸਾਨ ਪਰਿਵਾਰਾਂ ਨੂੰ ਆਮਦਨ ਸਹਾਇਤਾ ਪ੍ਰਦਾਨ ਕਰਦੀ ਹੈ। ਇਸ ਯੋਜਨਾ ਦੇ ਅਧੀਨ ਯੋਗ ਕਿਸਾਨਾਂ ਨੂੰ ਖੇਤੀਬਾੜੀ ਅਤੇ ਘਰੇਲੂ ਖਰਚਿਆਂ ਨੂੰ ਪੂਰਾ ਕਰਨ ਲਈ ਪ੍ਰਤੀ ਸਾਲ ₹6,000 ਦਿੱਤੇ ਜਾਂਦੇ ਹਨ। ਇਹ ਰਕਮ ਡਾਇਰੈਕਟ ਬੈਨਿਫਿਟ ਟ੍ਰਾਂਸਫਰ (DBT) ਰਾਹੀਂ ਸਿੱਧੀ ਕਿਸਾਨ ਦੇ ਬੈਂਕ ਖਾਤੇ ਵਿੱਚ ਭੇਜੀ ਜਾਂਦੀ ਹੈ।\n\nਇਸ ਯੋਜਨਾ ਦਾ ਉਦੇਸ਼ ਛੋਟੇ ਅਤੇ ਸੀਮਾਂਤ ਕਿਸਾਨਾਂ ਨੂੰ ਵਿੱਤੀ ਸਹਾਇਤਾ ਦੇਣਾ ਹੈ ਤਾਂ ਜੋ ਉਹ ਬੀਜ, ਖਾਦ ਅਤੇ ਹੋਰ ਖੇਤੀਬਾੜੀ ਇਨਪੁੱਟ ਖਰੀਦ ਸਕਣ ਅਤੇ ਗੈਰ-ਸਰਕਾਰੀ ਕਰਜ਼ਿਆਂ 'ਤੇ ਨਿਰਭਰ ਨਾ ਰਹਿਣ।	["ਯੋਗ ਕਿਸਾਨ ਪਰਿਵਾਰਾਂ ਨੂੰ ਪ੍ਰਤੀ ਸਾਲ ₹6,000 ਦੀ ਵਿੱਤੀ ਸਹਾਇਤਾ।", "ਰਕਮ ਹਰ ਚਾਰ ਮਹੀਨੇ ਬਾਅਦ ₹2,000 ਦੀਆਂ 3 ਕਿਸ਼ਤਾਂ ਵਿੱਚ ਦਿੱਤੀ ਜਾਂਦੀ ਹੈ।", "ਪੈਸਾ DBT (Direct Benefit Transfer) ਰਾਹੀਂ ਸਿੱਧਾ ਬੈਂਕ ਖਾਤੇ ਵਿੱਚ ਭੇਜਿਆ ਜਾਂਦਾ ਹੈ।", "ਕਿਸਾਨਾਂ ਨੂੰ ਬੀਜ, ਖਾਦ ਅਤੇ ਖੇਤੀਬਾੜੀ ਇਨਪੁੱਟ ਖਰੀਦਣ ਵਿੱਚ ਮਦਦ ਕਰਦਾ ਹੈ।", "ਗੈਰ-ਸਰਕਾਰੀ ਕਰਜ਼ਿਆਂ ਜਾਂ ਸਾਹੂਕਾਰਾਂ 'ਤੇ ਨਿਰਭਰਤਾ ਘਟਾਉਂਦਾ ਹੈ।", "ਛੋਟੇ ਅਤੇ ਸੀਮਾਂਤ ਕਿਸਾਨਾਂ ਦੀ ਆਮਦਨ ਸਥਿਰਤਾ ਨੂੰ ਸਮਰਥਨ ਦਿੰਦਾ ਹੈ।", "ਭਾਰਤ ਭਰ ਦੇ ਕਰੋੜਾਂ ਕਿਸਾਨ ਪਰਿਵਾਰਾਂ ਨੂੰ ਲਾਭ ਮਿਲਦਾ ਹੈ।"]	["ਆਵੇਦਕ ਭਾਰਤ ਦਾ ਨਾਗਰਿਕ ਹੋਣਾ ਚਾਹੀਦਾ ਹੈ।", "ਖੇਤੀਯੋਗ ਜ਼ਮੀਨ ਵਾਲਾ ਕਿਸਾਨ ਪਰਿਵਾਰ ਹੋਣਾ ਚਾਹੀਦਾ ਹੈ।", "ਜ਼ਮੀਨ ਦੇ ਰਿਕਾਰਡ ਰਾਜ ਜਾਂ ਕੇਂਦਰ ਸ਼ਾਸਿਤ ਪ੍ਰਦੇਸ਼ ਦੇ ਰਿਕਾਰਡ ਵਿੱਚ ਕਿਸਾਨ ਦੇ ਨਾਮ 'ਤੇ ਦਰਜ ਹੋਣੇ ਚਾਹੀਦੇ ਹਨ।", "ਆਧਾਰ ਕਾਰਡ ਅਰਜ਼ੀ ਨਾਲ ਲਿੰਕ ਹੋਣਾ ਚਾਹੀਦਾ ਹੈ।", "DBT ਭੁਗਤਾਨ ਲਈ ਬੈਂਕ ਖਾਤਾ ਆਧਾਰ ਨਾਲ ਲਿੰਕ ਹੋਣਾ ਚਾਹੀਦਾ ਹੈ।", "ਕਿਸ਼ਤਾਂ ਪ੍ਰਾਪਤ ਕਰਨ ਲਈ e-KYC ਪੂਰਾ ਕਰਨਾ ਲਾਜ਼ਮੀ ਹੈ।", "ਛੋਟੇ ਅਤੇ ਵੱਡੇ ਦੋਵੇਂ ਕਿਸਮ ਦੇ ਜ਼ਮੀਨਧਾਰੀ ਕਿਸਾਨ ਅਰਜ਼ੀ ਦੇ ਸਕਦੇ ਹਨ।", "ਅਯੋਗ ਸ਼੍ਰੇਣੀ - ਸੰਸਥਾਗਤ ਜ਼ਮੀਨਧਾਰੀ, ਕੇਂਦਰ ਜਾਂ ਰਾਜ ਸਰਕਾਰ ਦੇ ਕਰਮਚਾਰੀ ਜਾਂ ਸੇਵਾਮੁਕਤ ਅਧਿਕਾਰੀ (Group D / Multi-Tasking Staff / Class IV ਤੋਂ ਇਲਾਵਾ), ਆਮਦਨ ਕਰ ਭਰਨ ਵਾਲੇ ਵਿਅਕਤੀ, ਮੌਜੂਦਾ ਜਾਂ ਪੁਰਾਣੇ ਸੰਵਿਧਾਨਕ ਪਦਧਾਰੀ (ਰਾਸ਼ਟਰਪਤੀ, ਮੰਤਰੀ, ਸੰਸਦ ਮੈਂਬਰ, ਵਿਧਾਇਕ ਆਦਿ), ਪੇਸ਼ੇਵਰ ਸੰਸਥਾਵਾਂ ਵਿੱਚ ਰਜਿਸਟਰ ਵਿਅਕਤੀ (ਡਾਕਟਰ, ਇੰਜੀਨੀਅਰ, ਵਕੀਲ, ਚਾਰਟਡ ਅਕਾਊਂਟੈਂਟ, ਆਰਕੀਟੈਕਟ), ₹10,000 ਤੋਂ ਵੱਧ ਮਹੀਨਾਵਾਰ ਪੈਨਸ਼ਨ ਲੈਣ ਵਾਲੇ ਵਿਅਕਤੀ (ਨਿੰਮ ਵਰਗ ਦੇ ਕਰਮਚਾਰੀਆਂ ਤੋਂ ਇਲਾਵਾ), ਵੱਡੀਆਂ ਸੰਸਥਾਗਤ ਖੇਤੀਬਾੜੀ ਜ਼ਮੀਨਾਂ ਦੇ ਮਾਲਕ।"]	["ਅਧਿਕਾਰਿਕ ਵੈੱਬਸਾਈਟ 'ਤੇ ਜਾਓ: https://pmkisan.gov.in", "“New Farmer Registration” 'ਤੇ ਕਲਿੱਕ ਕਰੋ।", "ਆਧਾਰ ਨੰਬਰ ਅਤੇ ਕੈਪਚਾ ਕੋਡ ਦਰਜ ਕਰੋ।", "ਰਜਿਸਟ੍ਰੇਸ਼ਨ ਫਾਰਮ ਭਰੋ: ਨਾਮ, ਰਾਜ / ਜ਼ਿਲ੍ਹਾ / ਪਿੰਡ, ਜ਼ਮੀਨ ਦੀ ਜਾਣਕਾਰੀ, ਬੈਂਕ ਖਾਤੇ ਦੀ ਜਾਣਕਾਰੀ।", "ਜ਼ਰੂਰੀ ਦਸਤਾਵੇਜ਼ ਅਪਲੋਡ ਕਰੋ (ਆਧਾਰ, ਜ਼ਮੀਨ ਰਿਕਾਰਡ, ਬੈਂਕ ਵੇਰਵੇ)।", "ਆਨਲਾਈਨ ਅਰਜ਼ੀ ਜਮ੍ਹਾਂ ਕਰੋ।", "e-KYC ਤਸਦੀਕ ਪੂਰੀ ਕਰੋ।", "ਅਧਿਕਾਰੀਆਂ ਵੱਲੋਂ ਤਸਦੀਕ ਤੋਂ ਬਾਅਦ ਕਿਸਾਨ ਨੂੰ ਲਾਭਪਾਤਰੀ ਸੂਚੀ ਵਿੱਚ ਸ਼ਾਮਲ ਕੀਤਾ ਜਾਂਦਾ ਹੈ ਅਤੇ ਕਿਸ਼ਤਾਂ ਸ਼ੁਰੂ ਹੋ ਜਾਂਦੀਆਂ ਹਨ।", "ਕਿਸਾਨ Common Service Centres (CSC) ਜਾਂ ਸਥਾਨਕ ਖੇਤੀਬਾੜੀ ਦਫਤਰਾਂ ਰਾਹੀਂ ਵੀ ਅਰਜ਼ੀ ਦੇ ਸਕਦੇ ਹਨ।"]
79	35	gu	પ્રધાનમંત્રી કિસાન સન્માન નિધિ (PM-KISAN)	પ્રધાનમંત્રી કિસાન સન્માન નિધિ (PM-KISAN) ભારત સરકારની એક કેન્દ્રીય ક્ષેત્ર યોજના છે જે દેશભરના જમીન ધરાવતા ખેડૂત પરિવારોને આવક સહાય પ્રદાન કરે છે. આ યોજના હેઠળ પાત્ર ખેડુતોને કૃષિ અને ઘરેલુ ખર્ચ પૂરાં કરવા માટે દર વર્ષે ₹6,000 આપવામાં આવે છે. આ રકમ ડાયરેક્ટ બેનેફિટ ટ્રાન્સફર (DBT) દ્વારા સીધી ખેડૂતના બેંક ખાતામાં જમા કરવામાં આવે છે.\n\nઆ યોજનાનો મુખ્ય ઉદ્દેશ નાના અને સીમાન્ત ખેડુતોને આર્થિક સહાય આપવાનો છે જેથી તેઓ બીજ, ખાતર અને અન્ય કૃષિ ઇનપુટ્સ ખરીદી શકે અને અનૌપચારિક કર્જ પર આધાર રાખવો ન પડે.	["પાત્ર ખેડૂત પરિવારોને દર વર્ષે ₹6,000 ની આર્થિક સહાય મળે છે.", "આ રકમ દર ચાર મહિને ₹2,000 ની ત્રણ હપ્તામાં આપવામાં આવે છે.", "પૈસા DBT (Direct Benefit Transfer) દ્વારા સીધા બેંક ખાતામાં જમા થાય છે.", "ખેડુતોને બીજ, ખાતર અને કૃષિ ઇનપુટ્સ ખરીદવામાં મદદ કરે છે.", "અનૌપચારિક કર્જદારો અથવા સાહૂકારો પર ખેડુતોની નિર્ભરતા ઘટાડે છે.", "નાના અને સીમાન્ત ખેડુતોની આવક સ્થિરતા વધારવામાં મદદ કરે છે.", "ભારતભરમાં કરોડો ખેડૂત પરિવારોને લાભ મળે છે."]	["અરજદાર ભારતનો નાગરિક હોવો જોઈએ.", "ખેતીલાયક જમીન ધરાવતો ખેડૂત પરિવાર હોવો જોઈએ.", "જમીનના રેકોર્ડ રાજ્ય અથવા કેન્દ્રશાસિત પ્રદેશના રેકોર્ડમાં ખેડૂતના નામે નોંધાયેલા હોવા જોઈએ.", "આધાર કાર્ડ અરજી સાથે જોડાયેલું હોવું જોઈએ.", "DBT ચુકવણી માટે બેંક ખાતું આધાર સાથે જોડાયેલું હોવું જોઈએ.", "હપ્તા મેળવવા માટે e-KYC પૂર્ણ કરવું જરૂરી છે.", "નાના અને મોટા બંને પ્રકારના જમીનધારક ખેડુતો અરજી કરી શકે છે.", "અપાત્ર વર્ગ - સંસ્થાગત જમીનધારકો, કેન્દ્ર અથવા રાજ્ય સરકારના કર્મચારીઓ અથવા નિવૃત અધિકારીઓ (Group D / Multi-Tasking Staff / Class IV સિવાય), આવકવેરા ભરતા વ્યક્તિઓ, હાલના અથવા પૂર્વ સંવિધાનિક પદાધિકારીઓ (રાષ્ટ્રપતિ, મંત્રીઓ, સાંસદો, ધારાસભ્યો વગેરે), વ્યાવસાયિક સંસ્થાઓમાં નોંધાયેલા વ્યાવસાયિકો (ડોક્ટર, ઇજનેર, વકીલ, ચાર્ટર્ડ એકાઉન્ટન્ટ, આર્કિટેક્ટ), ₹10,000 થી વધુ માસિક પેન્શન મેળવનારા વ્યક્તિઓ (નીચા વર્ગના કર્મચારીઓ સિવાય), મોટી સંસ્થાગત કૃષિ જમીન ધરાવતા વ્યક્તિઓ."]	["સત્તાવાર વેબસાઇટ પર જાઓ: https://pmkisan.gov.in", "“New Farmer Registration” પર ક્લિક કરો.", "આધાર નંબર અને કૅપ્ચા કોડ દાખલ કરો.", "નોંધણી ફોર્મ ભરો: નામ, રાજ્ય / જિલ્લો / ગામ, જમીન વિગતો, બેંક ખાતાની માહિતી.", "જરૂરી દસ્તાવેજો અપલોડ કરો (આધાર, જમીન રેકોર્ડ, બેંક વિગતો).", "ઓનલાઇન અરજી સબમિટ કરો.", "e-KYC ચકાસણી પૂર્ણ કરો.", "સત્તાધિકારીઓ દ્વારા ચકાસણી પછી ખેડૂતને લાભાર્થી યાદીમાં ઉમેરવામાં આવે છે અને હપ્તા શરૂ થાય છે.", "ખેડુતો Common Service Centres (CSC) અથવા સ્થાનિક કૃષિ કચેરીઓ દ્વારા પણ અરજી કરી શકે છે."]
80	35	kn	ಪ್ರಧಾನಮಂತ್ರಿ ಕಿಸಾನ್ ಸಮ್ಮಾನ್ ನಿಧಿ (PM-KISAN)	ಪ್ರಧಾನಮಂತ್ರಿ ಕಿಸಾನ್ ಸಮ್ಮಾನ್ ನಿಧಿ (PM-KISAN) ಭಾರತ ಸರ್ಕಾರದ ಕೇಂದ್ರ ವಲಯ ಯೋಜನೆಯಾಗಿದ್ದು ದೇಶದಾದ್ಯಂತ ಭೂಮಿಯುಳ್ಳ ರೈತ ಕುಟುಂಬಗಳಿಗೆ ಆದಾಯ ಸಹಾಯವನ್ನು ಒದಗಿಸುತ್ತದೆ. ಈ ಯೋಜನೆಯಡಿ ಅರ್ಹ ರೈತರಿಗೆ ಕೃಷಿ ಮತ್ತು ಗೃಹ ಖರ್ಚುಗಳನ್ನು ನಿರ್ವಹಿಸಲು ವರ್ಷಕ್ಕೆ ₹6,000 ನೀಡಲಾಗುತ್ತದೆ. ಈ ಮೊತ್ತವನ್ನು ಡೈರೆಕ್ಟ್ ಬೆನೆಫಿಟ್ ಟ್ರಾನ್ಸ್‌ಫರ್ (DBT) ಮೂಲಕ ನೇರವಾಗಿ ರೈತನ ಬ್ಯಾಂಕ್ ಖಾತೆಗೆ ಜಮಾ ಮಾಡಲಾಗುತ್ತದೆ.\n\nಈ ಯೋಜನೆಯ ಉದ್ದೇಶ ಸಣ್ಣ ಮತ್ತು ಅಲ್ಪಭೂಧಾರಕ ರೈತರಿಗೆ ಆರ್ಥಿಕ ಸಹಾಯ ನೀಡುವುದಾಗಿದೆ, ಇದರಿಂದ ಅವರು ಬೀಜ, ರಸಗೊಬ್ಬರ ಮತ್ತು ಇತರ ಕೃಷಿ ಒಳಿತಗಳನ್ನು ಖರೀದಿಸಬಹುದು ಮತ್ತು ಅನೌಪಚಾರಿಕ ಸಾಲಗಳ ಮೇಲೆ ಅವಲಂಬಿತರಾಗಬೇಕಾಗಿಲ್ಲ.	["ಅರ್ಹ ರೈತ ಕುಟುಂಬಗಳಿಗೆ ವರ್ಷಕ್ಕೆ ₹6,000 ಆರ್ಥಿಕ ಸಹಾಯ.", "ಈ ಮೊತ್ತವನ್ನು ಪ್ರತಿ ನಾಲ್ಕು ತಿಂಗಳಿಗೆ ₹2,000ರಂತೆ ಮೂರು ಕಂತುಗಳಲ್ಲಿ ನೀಡಲಾಗುತ್ತದೆ.", "ಹಣವನ್ನು DBT (Direct Benefit Transfer) ಮೂಲಕ ನೇರವಾಗಿ ಬ್ಯಾಂಕ್ ಖಾತೆಗೆ ಜಮಾ ಮಾಡಲಾಗುತ್ತದೆ.", "ರೈತರಿಗೆ ಬೀಜ, ರಸಗೊಬ್ಬರ ಮತ್ತು ಕೃಷಿ ಒಳಿತಗಳನ್ನು ಖರೀದಿಸಲು ಸಹಾಯ ಮಾಡುತ್ತದೆ.", "ಅನೌಪಚಾರಿಕ ಸಾಲದಾತರು ಅಥವಾ ಸಾಹುಕಾರರ ಮೇಲೆ ರೈತರ ಅವಲಂಬನೆಯನ್ನು ಕಡಿಮೆ ಮಾಡುತ್ತದೆ.", "ಸಣ್ಣ ಮತ್ತು ಅಲ್ಪಭೂಧಾರಕ ರೈತರ ಆದಾಯ ಸ್ಥಿರತೆಯನ್ನು ಬೆಂಬಲಿಸುತ್ತದೆ.", "ಭಾರತದಾದ್ಯಂತ ಕೋಟ್ಯಂತರ ರೈತ ಕುಟುಂಬಗಳಿಗೆ ಪ್ರಯೋಜನ ನೀಡುತ್ತದೆ."]	["ಅರ್ಜಿದಾರರು ಭಾರತೀಯ ನಾಗರಿಕರಾಗಿರಬೇಕು.", "ಕೃಷಿಯೋಗ್ಯ ಭೂಮಿಯುಳ್ಳ ರೈತ ಕುಟುಂಬವಾಗಿರಬೇಕು.", "ಭೂ ದಾಖಲೆಗಳು ರಾಜ್ಯ ಅಥವಾ ಕೇಂದ್ರಾಡಳಿತ ಪ್ರದೇಶದ ದಾಖಲೆಗಳಲ್ಲಿ ರೈತನ ಹೆಸರಿನಲ್ಲಿ ಇರಬೇಕು.", "ಆಧಾರ್ ಕಾರ್ಡ್ ಅರ್ಜಿಯೊಂದಿಗೆ ಲಿಂಕ್ ಆಗಿರಬೇಕು.", "DBT ಪಾವತಿಗಾಗಿ ಬ್ಯಾಂಕ್ ಖಾತೆ ಆಧಾರ್‌ಗೆ ಲಿಂಕ್ ಆಗಿರಬೇಕು.", "ಕಂತುಗಳನ್ನು ಪಡೆಯಲು e-KYC ಪೂರ್ಣಗೊಳಿಸುವುದು ಕಡ್ಡಾಯ.", "ಸಣ್ಣ ಮತ್ತು ದೊಡ್ಡ ಭೂಧಾರಕ ರೈತರು ಇಬ್ಬರೂ ಅರ್ಜಿ ಸಲ್ಲಿಸಬಹುದು.", "ಅರ್ಹರಲ್ಲದವರು - ಸಂಸ್ಥಾತ್ಮಕ ಭೂಮಿಯ ಮಾಲೀಕರು, ಕೇಂದ್ರ ಅಥವಾ ರಾಜ್ಯ ಸರ್ಕಾರದ ನೌಕರರು ಅಥವಾ ನಿವೃತ್ತ ಅಧಿಕಾರಿಗಳು (Group D / Multi-Tasking Staff / Class IV ಹೊರತುಪಡಿಸಿ), ಆದಾಯ ತೆರಿಗೆ ಪಾವತಿಸುವವರು, ಪ್ರಸ್ತುತ ಅಥವಾ ಮಾಜಿ ಸಂವಿಧಾನಿಕ ಹುದ್ದೆಧಾರರು (ರಾಷ್ಟ್ರಪತಿ, ಸಚಿವರು, ಸಂಸದರು, ಶಾಸಕರು ಇತ್ಯಾದಿ), ವೃತ್ತಿಪರ ಸಂಸ್ಥೆಗಳಲ್ಲಿ ನೋಂದಾಯಿತ ವೃತ್ತಿಪರರು (ವೈದ್ಯರು, ಇಂಜಿನಿಯರ್‌ಗಳು, ವಕೀಲರು, ಚಾರ್ಟರ್ಡ್ ಅಕೌಂಟೆಂಟ್‌ಗಳು, ಆರ್ಕಿಟೆಕ್ಟ್‌ಗಳು), ತಿಂಗಳಿಗೆ ₹10,000ಕ್ಕಿಂತ ಹೆಚ್ಚು ಪಿಂಚಣಿ ಪಡೆಯುವವರು (ಕೀಳು ವರ್ಗದ ನೌಕರರನ್ನು ಹೊರತುಪಡಿಸಿ), ದೊಡ್ಡ ಸಂಸ್ಥಾತ್ಮಕ ಕೃಷಿ ಭೂಮಿಯ ಮಾಲೀಕರು."]	["ಅಧಿಕೃತ ವೆಬ್‌ಸೈಟ್‌ಗೆ ಭೇಟಿ ನೀಡಿ: https://pmkisan.gov.in", "“New Farmer Registration” ಮೇಲೆ ಕ್ಲಿಕ್ ಮಾಡಿ.", "ಆಧಾರ್ ಸಂಖ್ಯೆ ಮತ್ತು ಕ್ಯಾಪ್ಚಾ ಕೋಡ್ ನಮೂದಿಸಿ.", "ನೋಂದಣಿ ಫಾರ್ಮ್ ಭರ್ತಿ ಮಾಡಿ: ಹೆಸರು, ರಾಜ್ಯ / ಜಿಲ್ಲೆ / ಗ್ರಾಮ, ಭೂಮಿಯ ವಿವರಗಳು, ಬ್ಯಾಂಕ್ ಖಾತೆ ವಿವರಗಳು.", "ಅಗತ್ಯ ದಾಖಲೆಗಳನ್ನು ಅಪ್‌ಲೋಡ್ ಮಾಡಿ (ಆಧಾರ್, ಭೂ ದಾಖಲೆ, ಬ್ಯಾಂಕ್ ವಿವರಗಳು).", "ಆನ್‌ಲೈನ್ ಅರ್ಜಿಯನ್ನು ಸಲ್ಲಿಸಿ.", "e-KYC ಪರಿಶೀಲನೆಯನ್ನು ಪೂರ್ಣಗೊಳಿಸಿ.", "ಅಧಿಕಾರಿಗಳ ಪರಿಶೀಲನೆಯ ನಂತರ ರೈತನನ್ನು ಲಾಭಾರ್ಥಿ ಪಟ್ಟಿಗೆ ಸೇರಿಸಲಾಗುತ್ತದೆ ಮತ್ತು ಕಂತುಗಳು ಆರಂಭವಾಗುತ್ತವೆ.", "ರೈತರು Common Service Centres (CSC) ಅಥವಾ ಸ್ಥಳೀಯ ಕೃಷಿ ಕಚೇರಿಗಳ ಮೂಲಕವೂ ಅರ್ಜಿ ಸಲ್ಲಿಸಬಹುದು."]
81	35	ml	പ്രധാനമന്ത്രി കിസാൻ സമ്മാൻ നിധി (PM-KISAN)	പ്രധാനമന്ത്രി കിസാൻ സമ്മാൻ നിധി (PM-KISAN) ഇന്ത്യ സർക്കാർ ആരംഭിച്ച ഒരു കേന്ദ്ര മേഖലയിലെ പദ്ധതിയാണ്. രാജ്യത്തുടനീളമുള്ള ഭൂമിയുള്ള കർഷക കുടുംബങ്ങൾക്ക് വരുമാന സഹായം നൽകുന്നതാണ് ഈ പദ്ധതി. ഈ പദ്ധതിയുടെ കീഴിൽ യോഗ്യരായ കർഷകർക്ക് വർഷം ₹6,000 ലഭിക്കും, ഇത് അവരുടെ കൃഷിയുടെയും കുടുംബച്ചെലവുകളുടെയും ആവശ്യങ്ങൾ നിറവേറ്റാൻ സഹായിക്കുന്നു. ഈ തുക Direct Benefit Transfer (DBT) വഴി നേരിട്ട് കർഷകന്റെ ബാങ്ക് അക്കൗണ്ടിലേക്ക് മാറ്റിവെക്കപ്പെടുന്നു.\n\nചെറുകിടയും പരിമിത ഭൂമിയുള്ള കർഷകർക്കും സാമ്പത്തിക സഹായം നൽകുകയും അവർക്ക് വിത്ത്, വളം തുടങ്ങിയ കൃഷി ഇൻപുട്ടുകൾ വാങ്ങാൻ സഹായിക്കുകയും ചെയ്യുന്നതാണ് ഈ പദ്ധതിയുടെ പ്രധാന ലക്ഷ്യം.	["യോഗ്യരായ കർഷക കുടുംബങ്ങൾക്ക് വർഷം ₹6,000 സാമ്പത്തിക സഹായം ലഭിക്കും.", "ഈ തുക നാല് മാസത്തിലൊരിക്കൽ ₹2,000 വീതം മൂന്ന് ഗഡുക്കളായി നൽകപ്പെടുന്നു.", "DBT (Direct Benefit Transfer) വഴി പണം നേരിട്ട് ബാങ്ക് അക്കൗണ്ടിലേക്ക് കൈമാറുന്നു.", "കർഷകർക്ക് വിത്ത്, വളം, മറ്റ് കൃഷി ഇൻപുട്ടുകൾ വാങ്ങാൻ സഹായിക്കുന്നു.", "അനൗപചാരിക വായ്പകളിലേക്കോ പണയക്കാരിലേക്കോ ഉള്ള ആശ്രയം കുറയ്ക്കുന്നു.", "ചെറുകിടയും പരിമിത ഭൂമിയുള്ള കർഷകരുടെ വരുമാന സ്ഥിരതയ്ക്ക് പിന്തുണ നൽകുന്നു.", "രാജ്യത്തുടനീളം കോടിക്കണക്കിന് കർഷക കുടുംബങ്ങൾക്ക് പ്രയോജനം ലഭിക്കുന്നു."]	["അപേക്ഷകൻ ഇന്ത്യൻ പൗരനായിരിക്കണം.", "കൃഷിയോഗ്യമായ ഭൂമി ഉള്ള കർഷക കുടുംബമായിരിക്കണം.", "ഭൂമിയുടെ രേഖകൾ സംസ്ഥാനമോ കേന്ദ്രഭരണ പ്രദേശമോ ഉള്ള രേഖകളിൽ കർഷകന്റെ പേരിൽ രജിസ്റ്റർ ചെയ്തിരിക്കണം.", "ആധാർ കാർഡ് അപേക്ഷയുമായി ബന്ധിപ്പിക്കണം.", "DBT ലഭിക്കാൻ ബാങ്ക് അക്കൗണ്ട് ആധാറുമായി ബന്ധിപ്പിക്കണം.", "ഗഡുക്കൾ ലഭിക്കാൻ e-KYC പൂർത്തിയാക്കണം.", "ചെറുകിടയും വലിയ ഭൂമിയുള്ള കർഷകർ ഇരുവരും അപേക്ഷിക്കാം.", "അർഹതയില്ലാത്തവർ - സ്ഥാപന ഭൂമിയുടമകൾ, കേന്ദ്ര അല്ലെങ്കിൽ സംസ്ഥാന സർക്കാർ ജീവനക്കാർ അല്ലെങ്കിൽ വിരമിച്ച ഉദ്യോഗസ്ഥർ (Group D / Multi-Tasking Staff / Class IV ഒഴികെ), വരുമാന നികുതി അടക്കുന്നവർ, നിലവിലുള്ള അല്ലെങ്കിൽ മുൻ ഭരണഘടനാപദവിയിലുള്ളവർ (പ്രസിഡന്റ്, മന്ത്രിമാർ, എംപിമാർ, എംഎൽഎമാർ തുടങ്ങിയവർ), പ്രൊഫഷണൽ സ്ഥാപനങ്ങളിൽ രജിസ്റ്റർ ചെയ്ത വിദഗ്ധർ (ഡോക്ടർമാർ, എൻജിനീയർമാർ, അഭിഭാഷകർ, ചാർട്ടേഡ് അക്കൗണ്ടന്റുകൾ, ആർക്കിടെക്റ്റുകൾ), മാസം ₹10,000ൽ കൂടുതൽ പെൻഷൻ ലഭിക്കുന്നവർ (താഴ്ന്ന വിഭാഗം ജീവനക്കാരെ ഒഴികെ), വലിയ സ്ഥാപന കാർഷിക ഭൂമിയുടെ ഉടമകൾ."]	["ഔദ്യോഗിക വെബ്‌സൈറ്റ് സന്ദർശിക്കുക: https://pmkisan.gov.in", "“New Farmer Registration” ക്ലിക്ക് ചെയ്യുക.", "ആധാർ നമ്പറും ക്യാപ്ച കോഡും നൽകുക.", "രജിസ്ട്രേഷൻ ഫോം പൂരിപ്പിക്കുക: പേര്, സംസ്ഥാനം / ജില്ല / ഗ്രാമം, ഭൂമി വിവരങ്ങൾ, ബാങ്ക് അക്കൗണ്ട് വിവരങ്ങൾ.", "ആവശ്യമായ രേഖകൾ അപ്‌ലോഡ് ചെയ്യുക (ആധാർ, ഭൂമി രേഖ, ബാങ്ക് വിവരങ്ങൾ).", "ഓൺലൈൻ അപേക്ഷ സമർപ്പിക്കുക.", "e-KYC സ്ഥിരീകരണം പൂർത്തിയാക്കുക.", "അധികൃത പരിശോധനയ്ക്ക് ശേഷം കർഷകനെ ഗുണഭോക്തൃ പട്ടികയിൽ ചേർക്കുകയും ഗഡുക്കൾ ആരംഭിക്കുകയും ചെയ്യും.", "കർഷകർ Common Service Centres (CSC) അല്ലെങ്കിൽ പ്രാദേശിക കാർഷിക ഓഫീസുകൾ വഴി അപേക്ഷിക്കാം."]
82	35	or	ପ୍ରଧାନମନ୍ତ୍ରୀ କିସାନ ସମ୍ମାନ ନିଧି (PM-KISAN)	ପ୍ରଧାନମନ୍ତ୍ରୀ କିସାନ ସମ୍ମାନ ନିଧି (PM-KISAN) ଭାରତ ସରକାରଙ୍କ ଏକ କେନ୍ଦ୍ରୀୟ କ୍ଷେତ୍ର ଯୋଜନା ଯାହା ଦେଶର ସମସ୍ତ ଭୂମିଧାରୀ କୃଷକ ପରିବାରଙ୍କୁ ଆୟ ସହାୟତା ପ୍ରଦାନ କରେ। ଏହି ଯୋଜନା ଅଧୀନରେ ଯୋଗ୍ୟ କୃଷକମାନେ ବର୍ଷକୁ ₹6,000 ପାଆନ୍ତି, ଯାହା ତାଙ୍କର କୃଷି ଏବଂ ଘରୋଇ ଖର୍ଚ୍ଚ ପୂରଣରେ ସହାୟତା କରେ। ଏହି ରାଶି Direct Benefit Transfer (DBT) ମାଧ୍ୟମରେ ସିଧାସଳଖ କୃଷକଙ୍କ ବ୍ୟାଙ୍କ ଖାତାକୁ ପଠାଯାଏ।\n\nଏହି ଯୋଜନାର ଉଦ୍ଦେଶ୍ୟ ଛୋଟ ଏବଂ ସୀମାନ୍ତ କୃଷକମାନଙ୍କୁ ଆର୍ଥିକ ସହାୟତା ଦେବା, ଯାହାଦ୍ୱାରା ସେମାନେ ବିଆ, ସାର ଏବଂ ଅନ୍ୟାନ୍ୟ କୃଷି ଇନପୁଟ୍ କିଣିପାରିବେ ଏବଂ ଅନୌପଚାରିକ ଋଣରେ ନିର୍ଭର କରିବାକୁ ପଡିବ ନାହିଁ।	["ଯୋଗ୍ୟ କୃଷକ ପରିବାରମାନଙ୍କୁ ବର୍ଷକୁ ₹6,000 ଆର୍ଥିକ ସହାୟତା।", "ଏହି ରାଶି ପ୍ରତି ଚାରି ମାସରେ ₹2,000 କରି ତିନୋଟି କିଷ୍ତିରେ ଦିଆଯାଏ।", "DBT (Direct Benefit Transfer) ମାଧ୍ୟମରେ ଟଙ୍କା ସିଧାସଳଖ ବ୍ୟାଙ୍କ ଖାତାକୁ ପଠାଯାଏ।", "କୃଷକମାନଙ୍କୁ ବିଆ, ସାର ଏବଂ କୃଷି ଇନପୁଟ୍ କିଣିବାରେ ସହାୟତା କରେ।", "ଅନୌପଚାରିକ ଋଣଦାତା କିମ୍ବା ସୁଦଖୋରମାନଙ୍କୁ ନିର୍ଭରତା କମାଏ।", "ଛୋଟ ଏବଂ ସୀମାନ୍ତ କୃଷକମାନଙ୍କ ଆୟ ସ୍ଥିରତାକୁ ସମର୍ଥନ କରେ।", "ଭାରତର କୋଟି କୋଟି କୃଷକ ପରିବାରମାନେ ଏହାର ଲାଭ ପାଆନ୍ତି।"]	["ଆବେଦକ ଭାରତର ନାଗରିକ ହେବା ଆବଶ୍ୟକ।", "କୃଷିଯୋଗ୍ୟ ଭୂମି ଥିବା କୃଷକ ପରିବାର ହେବା ଆବଶ୍ୟକ।", "ଭୂମି ରେକର୍ଡ୍ ରାଜ୍ୟ କିମ୍ବା କେନ୍ଦ୍ରଶାସିତ ଅଞ୍ଚଳର ରେକର୍ଡରେ କୃଷକଙ୍କ ନାମରେ ଥିବା ଉଚିତ।", "ଆଧାର କାର୍ଡ୍ ଆବେଦନ ସହ ଯୋଡାଯିବା ଆବଶ୍ୟକ।", "DBT ପାଇଁ ବ୍ୟାଙ୍କ ଖାତା ଆଧାର ସହ ଲିଙ୍କ୍ ହେବା ଆବଶ୍ୟକ।", "କିଷ୍ତି ପାଇବା ପାଇଁ e-KYC ପୂରଣ କରିବା ଆବଶ୍ୟକ।", "ଛୋଟ ଏବଂ ବଡ଼ ଭୂମିଧାରୀ କୃଷକମାନେ ଆବେଦନ କରିପାରିବେ।", "ଅଯୋଗ୍ୟ - ସଂସ୍ଥାଗତ ଭୂମିଧାରୀ, କେନ୍ଦ୍ର କିମ୍ବା ରାଜ୍ୟ ସରକାର କର୍ମଚାରୀ କିମ୍ବା ପେନସନର (Group D / Multi-Tasking Staff / Class IV ବ୍ୟତୀତ), ଆୟକର ଦେଉଥିବା ବ୍ୟକ୍ତି, ପୂର୍ବ କିମ୍ବା ବର୍ତ୍ତମାନ ସଂବିଧାନିକ ପଦଧାରୀ (ରାଷ୍ଟ୍ରପତି, ମନ୍ତ୍ରୀ, ସାଂସଦ, ବିଧାୟକ ଇତ୍ୟାଦି), ବୃତ୍ତିଗତ ସଂଗଠନରେ ନିବନ୍ଧିତ ବ୍ୟକ୍ତି (ଡାକ୍ତର, ଇଞ୍ଜିନିୟର, ଆଇନଜୀବୀ, ଚାର୍ଟାର୍ଡ ଆକାଉଣ୍ଟାଣ୍ଟ, ଆର୍କିଟେକ୍ଟ), ₹10,000 ଠାରୁ ଅଧିକ ପେନସନ ପାଉଥିବା ବ୍ୟକ୍ତିମାନେ, ବଡ଼ ସଂସ୍ଥାଗତ କୃଷି ଭୂମିର ମାଲିକମାନେ।"]	["ଅଧିକୃତ ୱେବସାଇଟକୁ ଯାଆନ୍ତୁ: https://pmkisan.gov.in", "“New Farmer Registration” ଉପରେ କ୍ଲିକ୍ କରନ୍ତୁ।", "ଆଧାର ନମ୍ବର ଏବଂ କ୍ୟାପଚା କୋଡ୍ ଦାଖଲ କରନ୍ତୁ।", "ନିବନ୍ଧନ ଫର୍ମ ପୂରଣ କରନ୍ତୁ: ନାମ, ରାଜ୍ୟ / ଜିଲ୍ଲା / ଗାଁ, ଭୂମି ବିବରଣୀ, ବ୍ୟାଙ୍କ ଖାତା ବିବରଣୀ।", "ଆବଶ୍ୟକ ଡକ୍ୟୁମେଣ୍ଟ ଅପଲୋଡ୍ କରନ୍ତୁ (ଆଧାର, ଭୂମି ରେକର୍ଡ, ବ୍ୟାଙ୍କ ବିବରଣୀ)।", "ଅନଲାଇନ୍ ଆବେଦନ ସବମିଟ୍ କରନ୍ତୁ।", "e-KYC ସତ୍ୟାପନ ପୂରଣ କରନ୍ତୁ।", "ସତ୍ୟାପନ ପରେ କୃଷକଙ୍କୁ ଲାଭାନ୍ବିତ ତାଲିକାରେ ଯୋଡାଯାଇ କିଷ୍ତି ଆରମ୍ଭ ହୁଏ।", "କୃଷକମାନେ Common Service Centres (CSC) କିମ୍ବା ସ୍ଥାନୀୟ କୃଷି କାର୍ଯ୍ୟାଳୟ ମାଧ୍ୟମରେ ମଧ୍ୟ ଆବେଦନ କରିପାରିବେ।"]
83	35	bn	প্রধানমন্ত্রী কিষান সম্মান নিধি (PM-KISAN)	প্রধানমন্ত্রী কিষান সম্মান নিধি (PM-KISAN) ভারতের কেন্দ্রীয় সরকারের একটি কেন্দ্রীয় খাতের প্রকল্প যা সারা দেশের ভূমিধারী কৃষক পরিবারকে আয় সহায়তা প্রদান করে। এই প্রকল্পের অধীনে যোগ্য কৃষকরা বছরে ₹6,000 পান, যা তাদের কৃষি ও পারিবারিক খরচ মেটাতে সহায়তা করে। এই অর্থ Direct Benefit Transfer (DBT) এর মাধ্যমে সরাসরি কৃষকের ব্যাংক অ্যাকাউন্টে জমা হয়।\n\nএই প্রকল্পের লক্ষ্য হল ছোট ও প্রান্তিক কৃষকদের আর্থিক সহায়তা প্রদান করা যাতে তারা বীজ, সার এবং অন্যান্য কৃষি উপকরণ কিনতে পারে এবং অনানুষ্ঠানিক ঋণের উপর নির্ভর করতে না হয়।	["যোগ্য কৃষক পরিবারদের বছরে ₹6,000 আর্থিক সহায়তা প্রদান করা হয়।", "এই অর্থ প্রতি চার মাসে ₹2,000 করে তিনটি কিস্তিতে দেওয়া হয়।", "DBT (Direct Benefit Transfer) এর মাধ্যমে টাকা সরাসরি ব্যাংক অ্যাকাউন্টে জমা হয়।", "কৃষকদের বীজ, সার এবং অন্যান্য কৃষি উপকরণ কিনতে সাহায্য করে।", "অপ্রাতিষ্ঠানিক ঋণদাতা বা মহাজনের উপর নির্ভরতা কমায়।", "ছোট ও প্রান্তিক কৃষকদের আয়ের স্থিতিশীলতা বজায় রাখতে সাহায্য করে।", "ভারত জুড়ে কোটি কোটি কৃষক পরিবার এই প্রকল্পের সুবিধা পায়।"]	["আবেদনকারীকে অবশ্যই ভারতের নাগরিক হতে হবে।", "কৃষিযোগ্য জমি সহ কৃষক পরিবার হতে হবে।", "জমির রেকর্ড রাজ্য বা কেন্দ্রশাসিত অঞ্চলের রেকর্ডে কৃষকের নামে থাকতে হবে।", "আধার কার্ড আবেদনপত্রের সাথে সংযুক্ত থাকতে হবে।", "DBT পেমেন্টের জন্য ব্যাংক অ্যাকাউন্ট আধারের সাথে সংযুক্ত থাকতে হবে।", "কিস্তি পাওয়ার জন্য e-KYC সম্পন্ন করা বাধ্যতামূলক।", "ছোট এবং বড় উভয় ধরনের জমির মালিক কৃষকরা আবেদন করতে পারেন।", "অযোগ্য - প্রাতিষ্ঠানিক জমির মালিক, কেন্দ্র বা রাজ্য সরকারের কর্মচারী বা অবসরপ্রাপ্ত কর্মকর্তা (Group D / Multi-Tasking Staff / Class IV ব্যতীত), আয়কর প্রদানকারী ব্যক্তি, বর্তমান বা প্রাক্তন সাংবিধানিক পদধারী (রাষ্ট্রপতি, মন্ত্রী, সাংসদ, বিধায়ক ইত্যাদি), পেশাগত সংস্থায় নিবন্ধিত পেশাজীবী (ডাক্তার, ইঞ্জিনিয়ার, আইনজীবী, চার্টার্ড অ্যাকাউন্ট্যান্ট, আর্কিটেক্ট), মাসে ₹10,000 এর বেশি পেনশনপ্রাপ্ত ব্যক্তি (নিম্নস্তরের কর্মচারী ব্যতীত), বড় প্রাতিষ্ঠানিক কৃষিজমির মালিক।"]	["অফিসিয়াল ওয়েবসাইটে যান: https://pmkisan.gov.in", "“New Farmer Registration” এ ক্লিক করুন।", "আধার নম্বর এবং ক্যাপচা কোড লিখুন।", "নিবন্ধন ফর্ম পূরণ করুন: নাম, রাজ্য / জেলা / গ্রাম, জমির বিবরণ, ব্যাংক অ্যাকাউন্টের বিবরণ।", "প্রয়োজনীয় নথি আপলোড করুন (আধার, জমির রেকর্ড, ব্যাংক বিবরণ)।", "অনলাইন আবেদন জমা দিন।", "e-KYC যাচাইকরণ সম্পন্ন করুন।", "যাচাইকরণের পর কৃষককে উপভোক্তা তালিকায় যুক্ত করা হয় এবং কিস্তি শুরু হয়।", "কৃষকরা Common Service Centres (CSC) বা স্থানীয় কৃষি অফিসের মাধ্যমেও আবেদন করতে পারেন।"]
84	36	hi	मुख्यमंत्री किसान कल्याण योजना (MKKY)	मुख्यमंत्री किसान कल्याण योजना मध्य प्रदेश सरकार द्वारा शुरू की गई एक राज्य स्तरीय योजना है, जिसका उद्देश्य किसानों को अतिरिक्त आर्थिक सहायता प्रदान करना है।\n\nयह योजना प्रधानमंत्री किसान सम्मान निधि के साथ मिलकर काम करती है, जिसके तहत किसानों को केंद्र सरकार द्वारा प्रति वर्ष ₹6,000 मिलते हैं। मुख्यमंत्री किसान कल्याण योजना के अंतर्गत मध्य प्रदेश सरकार किसानों को अतिरिक्त ₹6,000 प्रति वर्ष प्रदान करती है, जिससे किसानों की आय बढ़ाने और कृषि खर्चों को पूरा करने में मदद मिलती है।\n\nयह राशि डायरेक्ट बेनिफिट ट्रांसफर (DBT) के माध्यम से सीधे किसानों के बैंक खातों में भेजी जाती है।	["पात्र किसानों को प्रति वर्ष ₹6,000 की आर्थिक सहायता प्रदान की जाती है।", "राशि ₹2,000 की 3 किस्तों में दी जाती है।", "पैसा DBT के माध्यम से सीधे बैंक खाते में भेजा जाता है।", "PM-KISAN का लाभ लेने वाले किसानों को राज्य सरकार से अतिरिक्त सहायता मिलती है।", "किसानों को बीज, उर्वरक और कृषि सामग्री खरीदने में मदद मिलती है।", "मध्य प्रदेश के किसानों की आय स्थिर रखने में सहायता करती है।", "आधुनिक खेती और कृषि विकास को प्रोत्साहित करती है।"]	["आवेदक मध्य प्रदेश का स्थायी निवासी होना चाहिए।", "आवेदक किसान होना चाहिए और कृषि कार्य में संलग्न होना चाहिए।", "आवेदक के पास कृषि योग्य भूमि होनी चाहिए।", "किसान PM-KISAN योजना के अंतर्गत पंजीकृत होना चाहिए।", "DBT के लिए आधार और बैंक खाता लिंक होना चाहिए।", "किसान की जानकारी स्थानीय राजस्व विभाग या पटवारी द्वारा सत्यापित की जाती है।", "अयोग्य श्रेणियाँ - PM-KISAN में पंजीकृत नहीं होने वाले व्यक्ति, मध्य प्रदेश के निवासी नहीं, खेती में संलग्न नहीं, आयकरदाता, सरकारी कर्मचारी या निर्वाचित प्रतिनिधि, गलत भूमि या व्यक्तिगत जानकारी देने वाले आवेदक।"]	["किसानों को पहले PM-KISAN योजना में पंजीकरण कराना होगा।", "स्थानीय पटवारी या राजस्व कार्यालय में जाएँ।", "मुख्यमंत्री किसान कल्याण योजना का आवेदन पत्र भरें।", "आवश्यक जानकारी दें: आधार संख्या, PM-KISAN पंजीकरण संख्या, भूमि विवरण, बैंक खाता विवरण।", "आवश्यक दस्तावेज जमा करें।", "पटवारी PM-KISAN रिकॉर्ड के साथ किसान की जानकारी का सत्यापन करता है।", "सत्यापन के बाद किसान का नाम पात्र लाभार्थी सूची में जोड़ा जाता है।", "आर्थिक सहायता सीधे बैंक खाते में भेज दी जाती है।", "किसान निम्न माध्यमों से भी आवेदन कर सकते हैं: स्थानीय पटवारी कार्यालय, जिला राजस्व विभाग कार्यालय, राज्य कृषि विभाग कार्यालय, कॉमन सर्विस सेंटर (CSC)।"]
85	36	mr	मुख्यमंत्री किसान कल्याण योजना (MKKY)	मुख्यमंत्री किसान कल्याण योजना ही मध्य प्रदेश शासनाने सुरू केलेली एक राज्यस्तरीय योजना आहे, ज्याचा उद्देश शेतकऱ्यांना अतिरिक्त आर्थिक मदत देणे हा आहे.\n\nही योजना प्रधानमंत्री किसान सन्मान निधी योजनेसह कार्य करते, ज्याअंतर्गत केंद्र सरकारकडून शेतकऱ्यांना दरवर्षी ₹6,000 मिळतात. मुख्यमंत्री किसान कल्याण योजना अंतर्गत मध्य प्रदेश सरकार शेतकऱ्यांना अतिरिक्त ₹6,000 प्रति वर्ष देते, ज्यामुळे शेतकऱ्यांचे उत्पन्न वाढविण्यास आणि शेतीसाठी लागणारा खर्च भागविण्यास मदत होते.\n\nही रक्कम डायरेक्ट बेनिफिट ट्रान्सफर (DBT) द्वारे थेट शेतकऱ्यांच्या बँक खात्यात जमा केली जाते.	["पात्र शेतकऱ्यांना दरवर्षी ₹6,000 आर्थिक सहाय्य दिले जाते.", "ही रक्कम ₹2,000 च्या 3 हप्त्यांमध्ये दिली जाते.", "रक्कम DBT द्वारे थेट बँक खात्यात जमा केली जाते.", "PM-KISAN योजनेचा लाभ घेणाऱ्या शेतकऱ्यांना राज्य सरकारकडून अतिरिक्त मदत मिळते.", "शेतकऱ्यांना बियाणे, खत आणि शेतीसाठी लागणारे साहित्य खरेदी करण्यास मदत होते.", "मध्य प्रदेशातील शेतकऱ्यांचे उत्पन्न स्थिर ठेवण्यास मदत होते.", "आधुनिक शेती पद्धती आणि कृषी विकासाला प्रोत्साहन देते."]	["अर्जदार मध्य प्रदेशचा कायमस्वरूपी रहिवासी असावा.", "अर्जदार शेतकरी असावा आणि शेतीमध्ये कार्यरत असावा.", "अर्जदाराकडे शेतीयोग्य जमीन असावी.", "शेतकरी PM-KISAN योजनेत नोंदणीकृत असावा.", "DBT साठी आधार आणि बँक खाते लिंक असणे आवश्यक आहे.", "शेतकऱ्याची माहिती स्थानिक महसूल विभाग किंवा पटवारीद्वारे पडताळली जाते.", "अपात्र श्रेणी - PM-KISAN मध्ये नोंदणी नसलेले व्यक्ती, मध्य प्रदेशचे रहिवासी नसलेले, शेतीत कार्यरत नसलेले, आयकर भरणारे, सरकारी कर्मचारी किंवा निवडून आलेले प्रतिनिधी, चुकीची जमीन किंवा वैयक्तिक माहिती देणारे अर्जदार."]	["शेतकऱ्यांनी प्रथम PM-KISAN योजनेत नोंदणी करणे आवश्यक आहे.", "स्थानिक पटवारी किंवा महसूल कार्यालयाला भेट द्या.", "मुख्यमंत्री किसान कल्याण योजना अर्ज फॉर्म भरा.", "आवश्यक माहिती द्या: आधार क्रमांक, PM-KISAN नोंदणी क्रमांक, जमीन तपशील, बँक खाते तपशील.", "आवश्यक कागदपत्रे जमा करा.", "पटवारी PM-KISAN नोंदींसोबत शेतकऱ्याची माहिती पडताळतो.", "पडताळणी झाल्यानंतर शेतकऱ्याचे नाव पात्र लाभार्थी यादीत समाविष्ट केले जाते.", "आर्थिक मदत थेट बँक खात्यात जमा केली जाते.", "शेतकरी खालील ठिकाणीही अर्ज करू शकतात: स्थानिक पटवारी कार्यालय, जिल्हा महसूल विभाग कार्यालय, राज्य कृषी विभाग कार्यालय, कॉमन सर्व्हिस सेंटर (CSC)."]
86	36	kn	ಮುಖ್ಯಮಂತ್ರಿ ಕಿಸಾನ್ ಕಲ್ಯಾಣ ಯೋಜನೆ (MKKY)	ಮುಖ್ಯಮಂತ್ರಿ ಕಿಸಾನ್ ಕಲ್ಯಾಣ ಯೋಜನೆ ಮಧ್ಯಪ್ರದೇಶ ಸರ್ಕಾರದಿಂದ ಪ್ರಾರಂಭಿಸಲಾದ ರಾಜ್ಯ ಸರ್ಕಾರದ ಯೋಜನೆಯಾಗಿದ್ದು, ರೈತರಿಗೆ ಹೆಚ್ಚುವರಿ ಆರ್ಥಿಕ ಸಹಾಯವನ್ನು ಒದಗಿಸುವುದೇ ಇದರ ಉದ್ದೇಶವಾಗಿದೆ.\n\nಈ ಯೋಜನೆ ಪ್ರಧಾನಮಂತ್ರಿ ಕಿಸಾನ್ ಸಮ್ಮಾನ್ ನಿಧಿ ಯೋಜನೆಯೊಂದಿಗೆ ಕಾರ್ಯನಿರ್ವಹಿಸುತ್ತದೆ. ಅದರಡಿ ರೈತರಿಗೆ ಕೇಂದ್ರ ಸರ್ಕಾರದಿಂದ ವರ್ಷಕ್ಕೆ ₹6,000 ನೀಡಲಾಗುತ್ತದೆ. ಮುಖ್ಯಮಂತ್ರಿ ಕಿಸಾನ್ ಕಲ್ಯಾಣ ಯೋಜನೆಯಡಿ ಮಧ್ಯಪ್ರದೇಶ ಸರ್ಕಾರವು ರೈತರಿಗೆ ವರ್ಷಕ್ಕೆ ಹೆಚ್ಚುವರಿ ₹6,000 ನೀಡುತ್ತದೆ, ಇದರಿಂದ ರೈತರ ಆದಾಯವನ್ನು ಹೆಚ್ಚಿಸಲು ಮತ್ತು ಕೃಷಿ ವೆಚ್ಚಗಳನ್ನು ನಿರ್ವಹಿಸಲು ಸಹಾಯವಾಗುತ್ತದೆ.\n\nಈ ಹಣವನ್ನು ಡೈರೆಕ್ಟ್ ಬೆನಿಫಿಟ್ ಟ್ರಾನ್ಸ್ಫರ್ (DBT) ಮೂಲಕ ರೈತರ ಬ್ಯಾಂಕ್ ಖಾತೆಗೆ ನೇರವಾಗಿ ಜಮಾ ಮಾಡಲಾಗುತ್ತದೆ.	["ಅರ್ಹ ರೈತರಿಗೆ ವರ್ಷಕ್ಕೆ ₹6,000 ಆರ್ಥಿಕ ಸಹಾಯ ನೀಡಲಾಗುತ್ತದೆ.", "ಮೊತ್ತವನ್ನು ₹2,000ರ 3 ಕಂತುಗಳಲ್ಲಿ ನೀಡಲಾಗುತ್ತದೆ.", "ಹಣವನ್ನು DBT ಮೂಲಕ ನೇರವಾಗಿ ಬ್ಯಾಂಕ್ ಖಾತೆಗೆ ಜಮಾ ಮಾಡಲಾಗುತ್ತದೆ.", "PM-KISAN ಲಾಭ ಪಡೆಯುವ ರೈತರಿಗೆ ರಾಜ್ಯ ಸರ್ಕಾರದಿಂದ ಹೆಚ್ಚುವರಿ ಸಹಾಯ ದೊರೆಯುತ್ತದೆ.", "ರೈತರು ಬೀಜ, ರಸಗೊಬ್ಬರ ಮತ್ತು ಕೃಷಿ ಸಾಮಗ್ರಿಗಳನ್ನು ಖರೀದಿಸಲು ಸಹಾಯವಾಗುತ್ತದೆ.", "ಮಧ್ಯಪ್ರದೇಶದ ರೈತರ ಆದಾಯ ಸ್ಥಿರವಾಗಲು ಸಹಾಯ ಮಾಡುತ್ತದೆ.", "ಆಧುನಿಕ ಕೃಷಿ ಪದ್ಧತಿಗಳನ್ನು ಉತ್ತೇಜಿಸುತ್ತದೆ."]	["ಅರ್ಜಿದಾರನು ಮಧ್ಯಪ್ರದೇಶದ ಶಾಶ್ವತ ನಿವಾಸಿಯಾಗಿರಬೇಕು.", "ಅರ್ಜಿದಾರನು ಕೃಷಿಯಲ್ಲಿ ತೊಡಗಿರುವ ರೈತನಾಗಿರಬೇಕು.", "ಅರ್ಜಿದಾರನ ಬಳಿ ಕೃಷಿಗೆ ಯೋಗ್ಯವಾದ ಭೂಮಿ ಇರಬೇಕು.", "ರೈತನು PM-KISAN ಯೋಜನೆಯಲ್ಲಿ ನೋಂದಾಯಿತನಾಗಿರಬೇಕು.", "DBTಗಾಗಿ ಆಧಾರ್ ಮತ್ತು ಬ್ಯಾಂಕ್ ಖಾತೆ ಲಿಂಕ್ ಆಗಿರಬೇಕು.", "ರೈತರ ವಿವರಗಳನ್ನು ಸ್ಥಳೀಯ ಪಟ್ವಾರಿ ಅಥವಾ ಆದಾಯ ಇಲಾಖೆಯಿಂದ ಪರಿಶೀಲಿಸಲಾಗುತ್ತದೆ.", "ಅರ್ಹತೆ ಇಲ್ಲದವರು: PM-KISAN ನಲ್ಲಿ ನೋಂದಾಯಿಸದವರು, ಮಧ್ಯಪ್ರದೇಶದ ನಿವಾಸಿಗಳಲ್ಲದವರು, ಕೃಷಿಯಲ್ಲಿ ತೊಡಗಿಸದವರು, ಆದಾಯ ತೆರಿಗೆ ಪಾವತಿಸುವವರು, ಸರ್ಕಾರಿ ನೌಕರರು ಅಥವಾ ಜನಪ್ರತಿನಿಧಿಗಳು, ತಪ್ಪು ಮಾಹಿತಿಯನ್ನು ನೀಡಿದವರು."]	["ಮೊದಲು ರೈತರು PM-KISAN ಯೋಜನೆಯಲ್ಲಿ ನೋಂದಾಯಿಸಬೇಕು.", "ಸ್ಥಳೀಯ ಪಟ್ವಾರಿ ಅಥವಾ ಆದಾಯ ಕಚೇರಿಗೆ ಭೇಟಿ ನೀಡಿ.", "ಮುಖ್ಯಮಂತ್ರಿ ಕಿಸಾನ್ ಕಲ್ಯಾಣ ಯೋಜನೆ ಅರ್ಜಿ ಫಾರ್ಮ್ ಭರ್ತಿ ಮಾಡಿ.", "ಈ ವಿವರಗಳನ್ನು ನೀಡಿ: ಆಧಾರ್ ಸಂಖ್ಯೆ, PM-KISAN ನೋಂದಣಿ ಸಂಖ್ಯೆ, ಭೂಮಿ ವಿವರಗಳು, ಬ್ಯಾಂಕ್ ಖಾತೆ ವಿವರಗಳು.", "ಅಗತ್ಯ ದಾಖಲೆಗಳನ್ನು ಸಲ್ಲಿಸಿ.", "ಪಟ್ವಾರಿ PM-KISAN ದಾಖಲೆಗಳೊಂದಿಗೆ ರೈತರ ವಿವರಗಳನ್ನು ಪರಿಶೀಲಿಸುತ್ತಾನೆ.", "ಪರಿಶೀಲನೆಯ ನಂತರ ರೈತರ ಹೆಸರು ಅರ್ಹ ಲಾಭಾರ್ಥಿಗಳ ಪಟ್ಟಿಗೆ ಸೇರಿಸಲಾಗುತ್ತದೆ.", "ಆರ್ಥಿಕ ಸಹಾಯ ನೇರವಾಗಿ ಬ್ಯಾಂಕ್ ಖಾತೆಗೆ ಜಮಾ ಮಾಡಲಾಗುತ್ತದೆ.", "ರೈತರು ಸ್ಥಳೀಯ ಪಟ್ವಾರಿ ಕಚೇರಿ, ಜಿಲ್ಲಾ ಆದಾಯ ಇಲಾಖೆ ಕಚೇರಿ, ರಾಜ್ಯ ಕೃಷಿ ಇಲಾಖೆ ಕಚೇರಿ ಅಥವಾ ಕಾಮನ್ ಸರ್ವಿಸ್ ಸೆಂಟರ್ (CSC) ಮೂಲಕವೂ ಅರ್ಜಿ ಸಲ್ಲಿಸಬಹುದು."]
87	36	bn	মুখ্যমন্ত্রী কৃষক কল্যাণ যোজনা (MKKY)	মুখ্যমন্ত্রী কৃষক কল্যাণ যোজনা মধ্যপ্রদেশ সরকারের একটি রাজ্য সরকারি প্রকল্প, যার উদ্দেশ্য কৃষকদের অতিরিক্ত আর্থিক সহায়তা প্রদান করা।\n\nএই প্রকল্পটি প্রধানমন্ত্রী কিসান সম্মান নিধি প্রকল্পের সাথে সমন্বয় করে কাজ করে। এই প্রকল্পের মাধ্যমে কৃষকরা কেন্দ্রীয় সরকারের কাছ থেকে বছরে ₹6,000 পান। মুখ্যমন্ত্রী কৃষক কল্যাণ যোজনার অধীনে মধ্যপ্রদেশ সরকার কৃষকদের অতিরিক্ত ₹6,000 প্রতি বছর প্রদান করে, যা কৃষকদের আয় বৃদ্ধি এবং কৃষি ব্যয় মেটাতে সাহায্য করে।\n\nএই অর্থ ডাইরেক্ট বেনিফিট ট্রান্সফার (DBT) এর মাধ্যমে সরাসরি কৃষকদের ব্যাংক অ্যাকাউন্টে পাঠানো হয়।	["যোগ্য কৃষকদের বছরে ₹6,000 আর্থিক সহায়তা প্রদান করা হয়।", "এই অর্থ ₹2,000 করে ৩টি কিস্তিতে দেওয়া হয়।", "DBT এর মাধ্যমে সরাসরি ব্যাংক অ্যাকাউন্টে অর্থ পাঠানো হয়।", "PM-KISAN সুবিধাভোগী কৃষকরা রাজ্য সরকারের কাছ থেকে অতিরিক্ত সহায়তা পান।", "কৃষকদের বীজ, সার এবং কৃষি সামগ্রী কেনার জন্য সাহায্য করে।", "মধ্যপ্রদেশের কৃষকদের আয়ের স্থিতিশীলতা বজায় রাখতে সহায়তা করে।", "আধুনিক কৃষি পদ্ধতি এবং কৃষি উন্নয়নকে উৎসাহিত করে।"]	["আবেদনকারীকে মধ্যপ্রদেশের স্থায়ী বাসিন্দা হতে হবে।", "আবেদনকারীকে কৃষক হতে হবে এবং কৃষিকাজে যুক্ত থাকতে হবে।", "আবেদনকারীর কৃষিযোগ্য জমি থাকতে হবে।", "কৃষককে PM-KISAN প্রকল্পে নিবন্ধিত হতে হবে।", "DBT এর জন্য আধার এবং ব্যাংক অ্যাকাউন্ট সংযুক্ত থাকতে হবে।", "কৃষকের তথ্য স্থানীয় রাজস্ব বিভাগ বা পাটোয়ারি দ্বারা যাচাই করা হয়।", "অযোগ্য বিভাগ: PM-KISAN এ নিবন্ধিত নন এমন ব্যক্তি, মধ্যপ্রদেশের বাসিন্দা নন, কৃষিকাজে যুক্ত নন, আয়করদাতা, সরকারি কর্মচারী বা নির্বাচিত প্রতিনিধি, ভুল তথ্য প্রদানকারী আবেদনকারী।"]	["প্রথমে কৃষকদের PM-KISAN প্রকল্পে নিবন্ধন করতে হবে।", "স্থানীয় পাটোয়ারি বা রাজস্ব অফিসে যান।", "মুখ্যমন্ত্রী কৃষক কল্যাণ যোজনার আবেদন ফর্ম পূরণ করুন।", "প্রয়োজনীয় তথ্য প্রদান করুন: আধার নম্বর, PM-KISAN নিবন্ধন নম্বর, জমির বিবরণ, ব্যাংক অ্যাকাউন্টের বিবরণ।", "প্রয়োজনীয় নথি জমা দিন।", "পাটোয়ারি PM-KISAN রেকর্ডের সাথে কৃষকের তথ্য যাচাই করেন।", "যাচাই সম্পন্ন হলে কৃষকের নাম যোগ্য সুবিধাভোগীর তালিকায় অন্তর্ভুক্ত করা হয়।", "আর্থিক সহায়তা সরাসরি ব্যাংক অ্যাকাউন্টে পাঠানো হয়।", "কৃষকরা স্থানীয় পাটোয়ারি অফিস, জেলা রাজস্ব অফিস, রাজ্য কৃষি বিভাগ অফিস বা কমন সার্ভিস সেন্টার (CSC) এর মাধ্যমে আবেদন করতে পারেন।"]
88	36	gu	મુખ્યમંત્રી કિસાન કલ્યાણ યોજના (MKKY)	મુખ્યમંત્રી કિસાન કલ્યાણ યોજના મધ્ય પ્રદેશ સરકાર દ્વારા શરૂ કરાયેલ રાજ્ય સરકારની યોજના છે, જેનો મુખ્ય ઉદ્દેશ ખેડૂતોને વધારાની આર્થિક મદદ પૂરી પાડવાનો છે.\n\nઆ યોજના પ્રધાનમંત્રી કિસાન સન્માન નિધિ યોજના સાથે જોડાઈને કામ કરે છે, જેમાં ખેડૂતોને કેન્દ્ર સરકાર તરફથી દર વર્ષે ₹6,000 આપવામાં આવે છે. મુખ્યમંત્રી કિસાન કલ્યાણ યોજના હેઠળ મધ્ય પ્રદેશ સરકાર ખેડૂતોને વધારાના ₹6,000 દર વર્ષે આપે છે, જેથી ખેડૂતોની આવક વધે અને ખેતી સંબંધિત ખર્ચો પુરો કરવામાં મદદ મળે.\n\nઆ રકમ ડાયરેક્ટ બેનિફિટ ટ્રાન્સફર (DBT) દ્વારા સીધી ખેડૂતોના બેંક ખાતામાં જમા કરવામાં આવે છે.	["પાત્ર ખેડૂતોને દર વર્ષે ₹6,000 ની આર્થિક સહાય આપવામાં આવે છે.", "આ રકમ ₹2,000 ની 3 હપ્તામાં આપવામાં આવે છે.", "રકમ DBT દ્વારા સીધી બેંક ખાતામાં જમા કરવામાં આવે છે.", "PM-KISAN લાભાર્થી ખેડૂતોને રાજ્ય સરકાર તરફથી વધારાની સહાય મળે છે.", "ખેડૂતોને બીજ, ખાતર અને ખેતી માટેની સામગ્રી ખરીદવામાં મદદ મળે છે.", "મધ્ય પ્રદેશના ખેડૂતોની આવકને સ્થિર રાખવામાં મદદ કરે છે.", "આધુનિક ખેતી પદ્ધતિઓ અને કૃષિ વિકાસને પ્રોત્સાહન આપે છે."]	["અરજદાર મધ્ય પ્રદેશનો કાયમી રહેવાસી હોવો જોઈએ.", "અરજદાર ખેડૂત હોવો જોઈએ અને ખેતીમાં જોડાયેલ હોવો જોઈએ.", "અરજદાર પાસે ખેતી માટે યોગ્ય જમીન હોવી જોઈએ.", "ખેડૂત PM-KISAN યોજનામાં નોંધાયેલ હોવો જોઈએ.", "DBT માટે આધાર અને બેંક ખાતું જોડાયેલ હોવું જરૂરી છે.", "ખેડૂતની વિગતો સ્થાનિક આવક વિભાગ અથવા પટવારી દ્વારા ચકાસવામાં આવે છે.", "અયોગ્ય વર્ગ: PM-KISAN માં નોંધણી ન કરેલા વ્યક્તિઓ, મધ્ય પ્રદેશના રહેવાસી ન હોય તેવા લોકો, ખેતીમાં જોડાયેલા ન હોય તેવા લોકો, આવક કરદાતા, સરકારી કર્મચારીઓ અથવા ચૂંટાયેલા પ્રતિનિધિઓ, ખોટી માહિતી આપનાર અરજદારો."]	["ખેડૂતોને પહેલા PM-KISAN યોજનામાં નોંધણી કરાવવી જરૂરી છે.", "સ્થાનિક પટવારી અથવા આવક કચેરીની મુલાકાત લો.", "મુખ્યમંત્રી કિસાન કલ્યાણ યોજના માટે અરજી ફોર્મ ભરો.", "આવશ્યક વિગતો આપો: આધાર નંબર, PM-KISAN નોંધણી નંબર, જમીનની વિગતો, બેંક ખાતાની વિગતો.", "આવશ્યક દસ્તાવેજો સબમિટ કરો.", "પટવારી PM-KISAN રેકોર્ડ સાથે ખેડૂતની વિગતોની ચકાસણી કરે છે.", "ચકાસણી બાદ ખેડૂતનું નામ પાત્ર લાભાર્થી યાદીમાં ઉમેરવામાં આવે છે.", "આર્થિક સહાય સીધી બેંક ખાતામાં જમા કરવામાં આવે છે.", "ખેડૂતો નીચેના માધ્યમો દ્વારા પણ અરજી કરી શકે છે: સ્થાનિક પટવારી કચેરી, જિલ્લા આવક વિભાગ કચેરી, રાજ્ય કૃષિ વિભાગ કચેરી, કોમન સર્વિસ સેન્ટર (CSC)."]
89	37	hi	प्रधानमंत्री कृषि सिंचाई योजना (PMKSY)	प्रधानमंत्री कृषि सिंचाई योजना (PMKSY) भारत सरकार की एक केंद्रीय योजना है जिसका उद्देश्य पूरे भारत में किसानों के लिए सिंचाई सुविधाओं में सुधार करना है।\n\nइस योजना का मुख्य उद्देश्य “हर खेत को पानी” और “पर ड्रॉप मोर क्रॉप” है, जिसका मतलब है कि कृषि में पानी का अधिक कुशल उपयोग किया जाए।\n\nPMKSY विभिन्न सिंचाई योजनाओं को एकीकृत करती है और ड्रिप तथा स्प्रिंकलर सिंचाई जैसी माइक्रो-इरिगेशन तकनीकों को बढ़ावा देती है, जिससे जल दक्षता और कृषि उत्पादकता बढ़ती है।	["हर खेत तक सिंचाई का पानी पहुँचाना (हर खेत को पानी)।", "माइक्रो-इरिगेशन तकनीकों के माध्यम से पानी के कुशल उपयोग को बढ़ावा देना।", "ड्रिप और स्प्रिंकलर सिंचाई प्रणालियों के उपयोग को प्रोत्साहित करना।", "कृषि उत्पादकता और फसल उत्पादन में वृद्धि करना।", "जल संसाधनों के संरक्षण में मदद करना।", "कृषि में पानी की बर्बादी को कम करना।", "सतत खेती को बढ़ावा देना।", "सिंचाई उपकरण और अवसंरचना के लिए वित्तीय सहायता या सब्सिडी प्रदान करना।", "बेहतर फसल उत्पादन के माध्यम से किसानों की आय बढ़ाना।"]	["आवेदक भारत का नागरिक होना चाहिए।", "आवेदक किसान होना चाहिए और कृषि गतिविधियों में संलग्न होना चाहिए।", "आवेदक के पास कृषि योग्य भूमि होनी चाहिए।", "ड्रिप या स्प्रिंकलर जैसी माइक्रो-इरिगेशन प्रणाली स्थापित करने के इच्छुक किसान आवेदन कर सकते हैं।", "व्यक्तिगत किसान और किसान समूह/सहकारी समितियाँ दोनों आवेदन कर सकते हैं।", "किसानों को राज्य कृषि या सिंचाई विभाग के माध्यम से पंजीकरण करना होगा।", "किसानों को सिंचाई परियोजनाओं के लिए राज्य सरकार द्वारा निर्धारित दिशानिर्देशों का पालन करना होगा।", "अयोग्य श्रेणी: खेती से जुड़े नहीं लोग, कृषि योग्य भूमि न रखने वाले आवेदक, सिंचाई या जल प्रबंधन से संबंधित न होने वाली परियोजनाएँ, गलत भूमि या खेती की जानकारी देने वाले आवेदक, राज्य की सिंचाई विकास योजना के अंतर्गत स्वीकृत न होने वाली भूमि।"]	["किसान राज्य कृषि या सिंचाई विभाग के माध्यम से आवेदन कर सकते हैं।", "आधिकारिक वेबसाइट पर जाएँ: https://pmksy.gov.in ।", "राज्य कृषि या सिंचाई विभाग से संपर्क करें।", "PMKSY आवेदन फॉर्म भरें।", "आवश्यक जानकारी दें: किसान विवरण, भूमि विवरण, सिंचाई आवश्यकता।", "आवश्यक दस्तावेज जमा करें।", "आवेदन की जाँच कृषि विभाग द्वारा की जाती है।", "स्वीकृति के बाद किसानों को सिंचाई सुविधाओं के लिए वित्तीय सहायता या सब्सिडी प्राप्त होती है।", "किसान इन माध्यमों से भी आवेदन कर सकते हैं: राज्य कृषि विभाग कार्यालय, कॉमन सर्विस सेंटर (CSC), जिला सिंचाई विभाग, कृषि विस्तार अधिकारी या कृषि विज्ञान केंद्र (KVK)।"]
90	37	mr	प्रधानमंत्री कृषी सिंचन योजना (PMKSY)	प्रधानमंत्री कृषी सिंचन योजना (PMKSY) ही भारत सरकारची एक केंद्रीय योजना आहे, ज्याचा उद्देश संपूर्ण भारतातील शेतकऱ्यांसाठी सिंचन सुविधा सुधारण्याचा आहे.\n\nया योजनेचे मुख्य उद्दिष्ट “हर खेत को पानी” आणि “पर ड्रॉप मोअर क्रॉप” हे आहे, ज्याचा अर्थ शेतीमध्ये पाण्याचा अधिक कार्यक्षम वापर करणे.\n\nPMKSY विविध सिंचन योजनांचे एकत्रीकरण करते आणि ड्रिप व स्प्रिंकलर सिंचन यांसारख्या मायक्रो-इरिगेशन तंत्रज्ञानाला प्रोत्साहन देते, ज्यामुळे पाण्याची कार्यक्षमता आणि कृषी उत्पादकता वाढते.	["प्रत्येक शेतापर्यंत सिंचनाचे पाणी पोहोचवणे (हर खेत को पानी).", "मायक्रो-इरिगेशन तंत्रज्ञानाद्वारे पाण्याचा कार्यक्षम वापर प्रोत्साहित करणे.", "ड्रिप आणि स्प्रिंकलर सिंचन प्रणालींचा वापर वाढवणे.", "कृषी उत्पादकता आणि पीक उत्पादन वाढवणे.", "पाण्याच्या संसाधनांचे संरक्षण करण्यात मदत करणे.", "शेतीमध्ये पाण्याची नासाडी कमी करणे.", "शाश्वत शेती पद्धतींना प्रोत्साहन देणे.", "सिंचन उपकरणे आणि पायाभूत सुविधांसाठी आर्थिक मदत किंवा अनुदान देणे.", "चांगल्या पीक उत्पादनामुळे शेतकऱ्यांचे उत्पन्न वाढवणे."]	["अर्जदार भारतीय नागरिक असावा.", "अर्जदार शेतकरी असावा आणि शेतीच्या कामात सहभागी असावा.", "अर्जदाराकडे शेतीयोग्य जमीन असावी.", "ड्रिप किंवा स्प्रिंकलर सिंचन प्रणाली बसवण्यास इच्छुक शेतकरी अर्ज करू शकतात.", "वैयक्तिक शेतकरी तसेच शेतकरी गट/सहकारी संस्था अर्ज करू शकतात.", "शेतकऱ्यांनी राज्य कृषी किंवा सिंचन विभागामार्फत नोंदणी करणे आवश्यक आहे.", "सिंचन प्रकल्पांसाठी राज्य सरकारने ठरवलेल्या मार्गदर्शक सूचनांचे पालन करणे आवश्यक आहे.", "अपात्र: शेतीत सहभागी नसलेले लोक, शेतीयोग्य जमीन नसलेले अर्जदार, सिंचन किंवा जलव्यवस्थापनाशी संबंधित नसलेले प्रकल्प, चुकीची माहिती देणारे अर्जदार, राज्याच्या सिंचन विकास योजनेंतर्गत मंजूर नसलेली जमीन."]	["शेतकरी राज्य कृषी किंवा सिंचन विभागामार्फत अर्ज करू शकतात.", "अधिकृत वेबसाइटला भेट द्या: https://pmksy.gov.in .", "राज्य कृषी किंवा सिंचन विभागाशी संपर्क साधा.", "PMKSY अर्ज फॉर्म भरा.", "आवश्यक माहिती द्या: शेतकरी माहिती, जमीन तपशील, सिंचनाची गरज.", "आवश्यक कागदपत्रे सादर करा.", "अर्जाची पडताळणी कृषी विभागाद्वारे केली जाते.", "मंजुरीनंतर शेतकऱ्यांना सिंचन सुविधांसाठी आर्थिक मदत किंवा अनुदान दिले जाते.", "शेतकरी खालील माध्यमांतूनही अर्ज करू शकतात: राज्य कृषी विभाग कार्यालय, कॉमन सर्व्हिस सेंटर (CSC), जिल्हा सिंचन विभाग, कृषी विस्तार अधिकारी किंवा कृषी विज्ञान केंद्र (KVK)."]
91	37	ta	பிரதான் மந்திரி கிருஷி சின்சாய் யோஜனா (PMKSY)	பிரதான் மந்திரி கிருஷி சின்சாய் யோஜனா (PMKSY) என்பது இந்திய அரசின் மத்திய அரசு திட்டமாகும். இந்த திட்டத்தின் முக்கிய நோக்கம் இந்திய முழுவதும் உள்ள விவசாயிகளுக்கான பாசன வசதிகளை மேம்படுத்துவது ஆகும்.\n\nஇந்த திட்டத்தின் முக்கிய இலக்கு “Har Khet Ko Pani” (ஒவ்வொரு வயலுக்கும் நீர்) மற்றும் “More Crop Per Drop” ஆகும். அதாவது விவசாயத்தில் நீரை திறமையாக பயன்படுத்துவதைக் கவனமாகக் கொண்டது.\n\nPMKSY பல்வேறு பாசன திட்டங்களை ஒருங்கிணைத்து, டிரிப் பாசனம் மற்றும் ஸ்பிரிங்கிளர் பாசனம் போன்ற மைக்ரோ பாசன தொழில்நுட்பங்களை ஊக்குவிக்கிறது. இதன் மூலம் நீர் பயன்பாடு திறமையாகி, விவசாய உற்பத்தி அதிகரிக்கிறது.	["ஒவ்வொரு விவசாய நிலத்திற்கும் பாசன நீர் கிடைக்க உறுதி செய்கிறது (Har Khet Ko Pani).", "மைக்ரோ பாசன முறைகள் மூலம் நீரை திறமையாக பயன்படுத்த உதவுகிறது.", "டிரிப் மற்றும் ஸ்பிரிங்கிளர் பாசன முறைகளை ஊக்குவிக்கிறது.", "விவசாய உற்பத்தி மற்றும் விளைச்சலை அதிகரிக்கிறது.", "நீர் வளங்களை பாதுகாக்க உதவுகிறது.", "விவசாயத்தில் நீர் வீணாகும் அளவை குறைக்கிறது.", "நிலையான மற்றும் நிலைத்த விவசாயத்தை ஊக்குவிக்கிறது.", "பாசன உபகரணங்கள் மற்றும் அமைப்புகளுக்கு நிதி உதவி அல்லது மானியம் வழங்குகிறது.", "மேம்பட்ட விளைச்சலின் மூலம் விவசாயிகளின் வருமானத்தை அதிகரிக்க உதவுகிறது."]	["விண்ணப்பதாரர் இந்திய குடிமகனாக இருக்க வேண்டும்.", "விண்ணப்பதாரர் விவசாயியாக இருந்து விவசாய செயல்பாடுகளில் ஈடுபட்டு இருக்க வேண்டும்.", "விவசாயத்திற்கு தகுந்த நிலம் இருக்க வேண்டும்.", "டிரிப் அல்லது ஸ்பிரிங்கிளர் மைக்ரோ பாசன முறைகளை அமைக்க விரும்பும் விவசாயிகள் விண்ணப்பிக்கலாம்.", "தனிப்பட்ட விவசாயிகள் மற்றும் விவசாயிகள் குழுக்கள் அல்லது கூட்டுறவுச் சங்கங்கள் விண்ணப்பிக்கலாம்.", "விவசாயிகள் மாநில வேளாண்மை அல்லது பாசனத் துறையில் பதிவு செய்ய வேண்டும்.", "மாநில அரசின் பாசன திட்ட வழிகாட்டுதல்களை பின்பற்ற வேண்டும்.", "தகுதி இல்லாதவர்கள்: விவசாயத்தில் ஈடுபடாதவர்கள், விவசாய நிலம் இல்லாதவர்கள், பாசனம் தொடர்பில்லாத திட்டங்கள், தவறான தகவல் வழங்கியவர்கள், மாநில பாசன திட்டத்தில் அனுமதி பெறாத நிலங்கள்."]	["விவசாயிகள் மாநில வேளாண்மை அல்லது பாசனத் துறையின் மூலம் விண்ணப்பிக்கலாம்.", "அதிகாரப்பூர்வ இணையதளத்தை பார்வையிடுங்கள்: https://pmksy.gov.in .", "மாநில வேளாண்மை அல்லது பாசனத் துறையுடன் தொடர்பு கொள்ளுங்கள்.", "PMKSY விண்ணப்பப் படிவத்தை நிரப்புங்கள்.", "தேவையான விவரங்களை வழங்குங்கள்: விவசாயி தகவல், நில விவரம், பாசன தேவைகள்.", "தேவையான ஆவணங்களை சமர்ப்பிக்கவும்.", "விண்ணப்பம் வேளாண்மை துறையால் சரிபார்க்கப்படும்.", "அனுமதி கிடைத்த பிறகு பாசன வசதிகளுக்கான நிதி உதவி அல்லது மானியம் வழங்கப்படும்.", "விவசாயிகள் கீழ்க்கண்ட இடங்களிலும் விண்ணப்பிக்கலாம்: மாநில வேளாண்மை துறை அலுவலகங்கள், Common Service Centres (CSC), மாவட்ட பாசன துறை, வேளாண்மை விரிவாக்க அதிகாரிகள் அல்லது Krishi Vigyan Kendras (KVKs)."]
92	37	te	ప్రధాన్ మంత్రి కృషి సించాయి యోజన (PMKSY)	ప్రధాన్ మంత్రి కృషి సించాయి యోజన (PMKSY) భారత ప్రభుత్వ కేంద్ర పథకం. ఈ పథకం ముఖ్య ఉద్దేశ్యం దేశవ్యాప్తంగా రైతులకు సాగునీటి సౌకర్యాలను మెరుగుపరచడం.\n\nఈ పథకం యొక్క ప్రధాన లక్ష్యం “Har Khet Ko Pani” (ప్రతి పొలానికి నీరు) మరియు “More Crop Per Drop”, అంటే వ్యవసాయంలో నీటిని సమర్థవంతంగా ఉపయోగించడం.\n\nPMKSY వివిధ సాగునీటి పథకాలను ఏకీకృతం చేస్తుంది మరియు డ్రిప్ మరియు స్ప్రింక్లర్ సాగునీటి విధానాల వంటి మైక్రో ఇరిగేషన్ సాంకేతికతలను ప్రోత్సహిస్తుంది. దీని ద్వారా నీటి వినియోగ సామర్థ్యం పెరిగి వ్యవసాయ ఉత్పత్తి పెరుగుతుంది.	["ప్రతి వ్యవసాయ భూమికి సాగునీరు అందేలా చేస్తుంది (Har Khet Ko Pani).", "మైక్రో ఇరిగేషన్ ద్వారా నీటిని సమర్థవంతంగా ఉపయోగించడాన్ని ప్రోత్సహిస్తుంది.", "డ్రిప్ మరియు స్ప్రింక్లర్ సాగునీటి విధానాలను ప్రోత్సహిస్తుంది.", "వ్యవసాయ ఉత్పత్తి మరియు దిగుబడిని పెంచుతుంది.", "నీటి వనరులను సంరక్షించడంలో సహాయపడుతుంది.", "వ్యవసాయంలో నీటి వృథాను తగ్గిస్తుంది.", "సుస్థిర వ్యవసాయ పద్ధతులను ప్రోత్సహిస్తుంది.", "సాగునీటి పరికరాలు మరియు మౌలిక సదుపాయాలకు ఆర్థిక సహాయం లేదా సబ్సిడీ అందిస్తుంది.", "మెరుగైన పంట ఉత్పత్తి ద్వారా రైతుల ఆదాయాన్ని పెంచుతుంది."]	["అభ్యర్థి భారతీయ పౌరుడు కావాలి.", "అభ్యర్థి రైతు అయి వ్యవసాయ కార్యకలాపాల్లో పాల్గొనాలి.", "వ్యవసాయానికి అనువైన భూమి ఉండాలి.", "డ్రిప్ లేదా స్ప్రింక్లర్ మైక్రో ఇరిగేషన్ వ్యవస్థలను ఏర్పాటు చేయాలనుకునే రైతులు దరఖాస్తు చేసుకోవచ్చు.", "వ్యక్తిగత రైతులు మరియు రైతు సమూహాలు లేదా సహకార సంఘాలు దరఖాస్తు చేసుకోవచ్చు.", "రైతులు రాష్ట్ర వ్యవసాయ లేదా సాగునీటి శాఖలో నమోదు చేసుకోవాలి.", "సాగునీటి ప్రాజెక్టులకు రాష్ట్ర ప్రభుత్వ మార్గదర్శకాలను అనుసరించాలి.", "అర్హత లేని వారు: వ్యవసాయంలో పాల్గొనని వారు, సాగు భూమి లేని వారు, సాగునీటి లేదా నీటి నిర్వహణకు సంబంధించినవి కాని ప్రాజెక్టులు, తప్పు సమాచారం ఇచ్చిన వారు, రాష్ట్ర సాగునీటి అభివృద్ధి ప్రణాళికలో అనుమతి పొందని భూములు."]	["రైతులు రాష్ట్ర వ్యవసాయ లేదా సాగునీటి శాఖ ద్వారా దరఖాస్తు చేసుకోవచ్చు.", "అధికారిక వెబ్‌సైట్ సందర్శించండి: https://pmksy.gov.in .", "రాష్ట్ర వ్యవసాయ లేదా సాగునీటి శాఖను సంప్రదించండి.", "PMKSY దరఖాస్తు ఫారం నింపండి.", "అవసరమైన వివరాలు ఇవ్వండి: రైతు సమాచారం, భూమి వివరాలు, సాగునీటి అవసరం.", "అవసరమైన పత్రాలను సమర్పించండి.", "దరఖాస్తును వ్యవసాయ శాఖ పరిశీలిస్తుంది.", "అనుమతి తరువాత సాగునీటి సదుపాయాల కోసం ఆర్థిక సహాయం లేదా సబ్సిడీ అందుతుంది.", "రైతులు ఈ మార్గాల ద్వారా కూడా దరఖాస్తు చేసుకోవచ్చు: రాష్ట్ర వ్యవసాయ శాఖ కార్యాలయాలు, Common Service Centres (CSC), జిల్లా సాగునీటి శాఖలు, వ్యవసాయ విస్తరణ అధికారులు లేదా Krishi Vigyan Kendras (KVKs)."]
\.


--
-- Data for Name: schemes_subsidies; Type: TABLE DATA; Schema: public; Owner: yuvraj
--

COPY public.schemes_subsidies (id, type, gov_level, state_or_org, start_date, end_date, status, official_link, funding_amount, image_url) FROM stdin;
2	Government	State	Madhya Pradesh	2023-06-01	\N	ACTIVE	https://example.com/scheme2	25000.00	https://example.com/image2.jpg
3	Private	\N	Tata Foundation	2024-02-15	2026-03-10	UPCOMING	https://example.com/scheme3	100000.00	https://example.com/image3.jpg
1	Government	State	Madhya Pradesh	2025-04-01	2026-03-31	ACTIVE	https://gov-scheme.com	50000.00	http.jpg
4	Government	State	Madhya Pradesh	2025-04-01	9999-04-05	ACTIVE	https://gov-scheme.com	50000.00	http.jpg
28	Government	Central	Ministry of Agriculture & Farmers Welfare	2015-02-10	9999-11-22	ACTIVE	https://soilhealth.dac.gov.in	0.00	https://currentaffairs.adda247.com/wp-content/uploads/multisite/sites/5/2023/02/20093650/Soil-Health-Card-Scheme.jpg
27	Government	Central	Ministry of Jal Shakti	2015-07-01	4444-11-11	ACTIVE	https://pmksy.gov.in	-1.00	https://img.indiafilings.com/learn/wp-content/uploads/2018/06/Pradhan-Mantri-Krishi-Sinchai-Yojana.jpg
26	Government	Central	Ministry of Agriculture & Farmers Welfare	2016-02-18	6666-06-06	ACTIVE	https://pmfby.gov.in	0.00	https://www.cropin.com/wp-content/uploads/2025/07/Pradhanmantri_phasal-Preview-Smart-Object-Group.webp
29	Government	State	Madhya Pradesh	2020-09-20	99999-01-09	ACTIVE	https://saara.mp.gov.in	0.00	https://images.kisanindia.in/wp-content/uploads/2025/08/PMFBY-2025-Claim-Kian-India_V_jpg--442x260-4g.webp?sw=412&dsz=442x260&iw=392&p=false&r=2.625
30	Government	State	Madhya Pradesh	2017-10-16	9999-09-09	ACTIVE	https://mpeuparjan.nic.in	0.00	https://static.langimg.com/nbt/thumb/124212534/bhavantar-yojana.jpg?imgsize=20132&width=1600&height=900&resizemode=75
34	Private	Central	ITC Limited	2000-06-25	9999-09-09	ACTIVE	https://www.itcportal.com/businesses/agri-business/e-choupal.aspx	0.00	https://s3.youthkiawaaz.com/wp-content/uploads/2011/08/07003102/ITC-e-Choupal.jpg
25	Government	Central	Ministry of Agriculture & Farmers Welfare	2024-02-24	4444-04-04	ACTIVE	https://pmkisan.gov.in	0.00	https://www.livehindustan.com/lh-img/smart/img/2026/03/11/original/pm_kisan_1763712773089_1763712776918_1773238047829.jpg
35	Government	Central	Ministry of Agriculture & Farmers Welfare	2024-02-24	4444-04-04	ACTIVE	https://pmkisan.gov.in	0.00	https://www.livehindustan.com/lh-img/smart/img/2026/03/11/original/pm_kisan_1763712773089_1763712776918_1773238047829.jpg
36	Government	State	Madhya Pradesh	2020-09-20	9999-01-09	ACTIVE	https://saara.mp.gov.in	0.00	https://images.kisanindia.in/wp-content/uploads/2025/08/PMFBY-2025-Claim-Kian-India_V_jpg--442x260-4g.webp?sw=412&dsz=442x260&iw=392&p=false&r=2.625
37	Government	Central	Ministry of Jal Shakti	2015-07-01	4444-11-11	ACTIVE	https://pmksy.gov.in	-1.00	https://img.indiafilings.com/learn/wp-content/uploads/2018/06/Pradhan-Mantri-Krishi-Sinchai-Yojana.jpg
\.


--
-- Data for Name: user_fcm_tokens; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.user_fcm_tokens (id, fcm_token, district, created_at, updated_at, language) FROM stdin;
154	edFzmauoRtig_VsH1G6sok:APA91bEUSFBe7dfMr7iypiBbpuGy5NWbyCxpYSHwgkfDfWzXmJP8ceqfEOfW3sXzihw7uMyQJ9mgq1GVhIK_VtNFSFryIX4pWJaQR1G07XfFrdz6DJV0WtE	Balaghat	2025-06-13 00:32:14.040033	2025-06-15 14:31:31.079921	hi
109	ExponentPushToken[myHmCbM3A5HFKxu8QUFje8]	Khargone	2025-04-18 02:40:24.351428	2025-04-18 07:59:55.259332	hi
160	dffpS0YAT3S0COGgDAhiV7:APA91bHhz6tKaX8toYQnWf4m6wGrrzsQ6ZQdkXdaRWoZiOrovqnILURs7cpD6HaIbMIHzj2cqtoutvuE6AJgl6Vo_MIE3_EoBQaq_xM4K-CfPMCu_LofA1M	\N	2025-06-13 15:07:45.44982	2025-07-03 05:43:31.88192	hi
118	ExponentPushToken[WuLNWUFVubcUTE-8FIoVAr]	South West Garo Hills	2025-04-18 13:33:29.487778	2025-04-18 13:36:49.312906	en
125	ExponentPushToken[xIahHAAf75dENPpX-KH1Sg]	\N	2025-04-18 16:01:46.085031	2025-04-18 16:01:46.085031	en
126	ExponentPushToken[9wmPN2PYbhIeN65tACLax3]	\N	2025-04-18 16:35:10.796883	2025-04-18 16:35:10.796883	en
127	ExponentPushToken[dA0P7XIbWFDPWVaTMMfepS]	\N	2025-04-19 03:29:57.698654	2025-04-19 03:29:57.698654	en
128	ExponentPushToken[ZXjsE_KQVe-sVbElBLDsmw]	\N	2025-04-21 09:56:30.193326	2025-04-21 09:56:30.193326	en
129	ExponentPushToken[C8u6sLDgSU5tVXUrADW9MC]	Chittor	2025-04-22 13:13:30.549175	2025-04-22 18:11:50.752817	en
134	ExponentPushToken[71I2C_Ae6MFUx_Qwhwfs2G]	Chittor	2025-04-23 12:13:10.690269	2025-04-24 20:21:41.180379	en
137	ExponentPushToken[tblWAtI2gVs5V50nRYhHp2]	\N	2025-05-02 11:52:08.052208	2025-05-02 11:52:08.052208	en
138	ExponentPushToken[4cOHVuL72gOI9UtHAabM_H]	Khargone	2025-05-18 08:59:19.158643	2025-05-18 09:08:09.891373	hi
140	ExponentPushToken[9YoSneJCv_1TvPRiiuf9qu]	\N	2025-06-07 05:28:12.799878	2025-06-07 05:28:12.799878	en
141	ExponentPushToken[uSRWLRPkFlir8pBplyVa8i]	Chittor	2025-06-08 15:35:08.777564	2025-06-08 15:35:08.777564	en
47	ExponentPushToken[iPf9HfCLa54SIg10xu8Gme]	\N	2025-03-26 14:21:14.868802	2025-03-30 14:23:12.420205	en
142	dMum8J4wSHCMtwYYEFUUGX:APA91bEcKFo3aFg-3EeWVtMZ5zUDMKIRtW0cXSSfxwNcNScAJ5J20-FYMv4yS2swsY9aDMODdu8DXzA6-H6PVI_ntnJvE-MheKchhEyIyYTf7nukh3ut6Cw	Krishna	2025-06-08 15:40:05.152098	2025-06-08 15:40:05.152098	en
143	cp1CWyp5TGWSxnX2EvuHYm:APA91bFJZBOCfThClxDjX0v7kzFMKjTI7N6XIlDjKG14yaiJF-8MDu4Qiq8oM1c8Ku5w-JzMC-LIPDpagFRSMYmB_xxyO_irnnHZKl3csXDnN7zXs2cnOzg	North and Middle Andaman	2025-06-08 20:41:55.325053	2025-06-08 20:41:56.474356	en
145	dAB4B_F1TiGSAX6c-aecek:APA91bHeQp2QEYjwU7vi1TTCETnJ1xMLVPYNOLb6Pp6vYmcEdDUJWocqb-fARKBxmOwaXW3XxhlEEpSI4Nnfv7EfwuBQfLSvnW2JKkbpTwgGO1y6VWVYYMw	\N	2025-06-09 16:43:12.089435	2025-06-09 16:43:12.089435	en
146	csEg8MobS9-a3ssEffKMrO:APA91bFTtlUW09hhzkNshyYzsCQgxfSpVSbjRI4jOnTkPIbiYDMeE8so0WPH4DHL2vELIrMR7KIcTE_eCnpwHGiP8gLByhlFL_lIodGeXYywUazbcX0hwY8	\N	2025-06-10 18:54:42.195186	2025-06-10 18:54:42.195186	en
147	eCl_IgtfRGeSUAzn326bBX:APA91bH1FpaYWhOV9L0RGN5hG-onS66azbeh_lJhsZvt5lt5_BBNqKFIm8if1Gw-hy2C_h63nWk0H_1WAGZAIWLDPgyKgh8Jo5T5qg4tfiELBmaPQ--dK70	\N	2025-06-11 16:43:51.2686	2025-06-11 16:43:51.2686	en
148	c8FB1FwxRiKvo3fvvH2iau:APA91bGgF71ONKEmN2t0fFcHlc3QOLdIErHxQpAC_ltPa_o5QUbS_X-_Zdys00CLmOgLjBBlB7x7wE3FdLtIrhurhS0j_KZFHrxioG9DFXEib31jbOwtW-k	\N	2025-06-12 15:36:45.147387	2025-06-12 15:36:45.147387	en
149	dIAUmedKRoKP_0OC1d1hRC:APA91bGVLRo87xRWkFrKRzS_8AZruG4jUnE03UHDeOup9Xf1s_BTEz5a74DERAGmG5Y9Yuu70LFbI6eT67UTDwR_SqZLQ1h0Rmr5vD-ATXleB4kbsAp_riE	\N	2025-06-12 16:08:03.885859	2025-06-12 16:08:03.885859	en
150	c-GH4swPTpGv_aI2jsGwvG:APA91bGh6GxuMq8mz_Ko9Z5vIK3k-ePZ_0kCM9PjtU57wsPaMH_30CY3yP25CeDO_fgg7aSmr6u8R8eoiVSiDiU9rBUWMwyIpjka_Q2n82bZPkCw7cb1DtY	\N	2025-06-12 16:59:44.770236	2025-06-12 16:59:44.770236	en
151	eJjvv7b9RHS9fuizZvXAxZ:APA91bF1eFoHHXvo1eUveuY_c2s3CABwii4shWNeomNno5OJxmEptdUbdoqY1_0g1Ywvmm1R10pU0WdD71Z0hjOk7rVJ0z9-ZEzI_2fKfRL7RPfMB5lMb_s	\N	2025-06-12 18:01:26.641285	2025-06-12 18:01:26.641285	en
152	cI1sy51MQ3-n870rSu8-bi:APA91bFeMrpkCFll0LyeXumV1fRY6fwJYYMPITeEmrEL42reGG81tozG48unzHmwrhsArGL9asoLdvwOCBhH64C4UyE4jbKS_da1F0SRPdvjzHQ8CnVEiwM	\N	2025-06-12 18:03:35.79568	2025-06-12 18:03:35.79568	en
153	fNDv7XCFSBWW2_VffqS553:APA91bHhKdQKTkNYYjkDvg9EQwJVLQZQEUa_kslbI2dCWRC-NmGQdkWrCU-hSjTAVYs4C4B8GD7ji8xv2dKQgMzrHcf7aiqh9HUQFQfmE9CL6XZg0WPWK0c	\N	2025-06-12 18:10:23.626553	2025-06-12 18:10:23.626553	en
10	ExponentPushToken[poe5Q3BfMwOqsRajtEcsMx]	\N	2025-03-20 17:30:13.802048	2025-03-23 07:34:56.525018	en
155	dgQy395pSZGqSVKUisndqn:APA91bH-5Ep8pOrpfRG_kIi-Uex_-QplePigB1zf66vhkYvWQb9Yr49jFLBEwmM8QTanVkOaUCrGFKxQdDvj0QgEuEr6-3sLdAWwoesUIdYnqSuYhuFHDMY	\N	2025-06-13 02:14:49.729208	2025-06-13 02:14:49.729208	en
156	fevvt6oaQ5GDc6KMduJCof:APA91bF4ZnOtm5DQWjAc7pcEhzfyzoFNaq19vYxGLhCSpvZIL0JHTAopq-84pEBzuv9JB3pIiec4qUuugZWrRVjYvOF2ng4Rmdpty78HKf6KocsCoKN-x-g	\N	2025-06-13 06:39:23.624378	2025-06-13 06:39:23.624378	en
85	ExponentPushToken[6x4G6vLVtd-3Xb9teGlvr7]	\N	2025-04-01 10:34:04.358888	2025-04-02 03:26:59.615467	en
102	ExponentPushToken[VzNp19F86J5BGcQoSTh8gZ]	\N	2025-04-02 03:37:54.064048	2025-04-02 03:40:35.489753	en
157	dzYepawESSevG1vzh7QeYo:APA91bHhRO9Qft6eKcy39Xjm1dQp4vDj9xET8dVmwhYGdBv-KLKRZBM4_KMB76V7eZ58g5o8O6J_EDF_wrw3Hzu3HvX24g-zfaw6COKNcz-aXHfKGy75YCc	\N	2025-06-13 06:45:43.407021	2025-06-13 06:45:43.407021	en
158	cLcArQwcT0mrF5tRcBvP_2:APA91bGufB6UQTVL5GnYJci9DcIZz9nROCXV6cxDnwTg8WFn8v0Js6Vy1J4oOkUvGoRJQ_Z4HL2XrWE2OiFZkn4H9ZQxy4a_sWOnDdu4gUtdjB86Cg3sjW8	\N	2025-06-13 09:17:53.556026	2025-06-13 09:17:53.556026	en
159	cTMJ6AqmQWmxsUm6bUoQuI:APA91bGSxxxRqjlFG7TPgIoDuq32NgvEB70lTMYDy4LKyvaXznmEkKUN_-gsNnb5iR7tU2n-DIfOskFSSO3pnIH3jLOsFVQGaP3fFTlUyzThEr3TD9HQ_VE	\N	2025-06-13 12:19:53.14655	2025-06-13 12:19:53.14655	en
104	ExponentPushToken[tfMBJeIzTQTNlbZgIbTifB]	Guntur	2025-04-02 08:23:12.015832	2025-04-02 08:26:31.098589	hi
108	ExponentPushToken[c1C5ChIQhyu2tvnsMiZK7F]	Cuddapah	2025-04-03 06:32:33.964768	2025-04-03 06:32:33.964768	en
161	cnbVQD8rRc-lmsv8aHu8kG:APA91bE1Zuqs0EF4pDFl7jwnSWoNe7MgyHk85blSaGsSj4l5GzZxioTVV8nRMnKHIUxP6mtOa-qu_EWm69wzR76fmLSg-JBjDXfgcIgW5k-R_1zANa84BDs	\N	2025-06-14 02:52:57.789008	2025-06-14 02:52:57.789008	en
162	ewxwZR58Qye0WqsB4zvu0j:APA91bFrH90ZiR4xB_p_I2XRv3TRZRC52vnQoflP0EPp8uu8MlqVUziTmecXhZKRRyhR6y_zxh8t1DBDdomXxK4e8aATBmDdSmGMCvGol0HBcq5okzQckLE	\N	2025-06-14 11:20:38.171495	2025-06-14 11:20:38.171495	en
163	f2GnlhbeSyC0a8Ng6-NF6c:APA91bGQlXYLu3UwVznmcBxtPVwLkLH5IFZr1INRcUJQvC0mG7rGS3fAbm36agJJdIAbJaW1etzYbahj1T1dPdZsKzdufy_MeejsIoVKG_MSCdmj1ey9Odw	\N	2025-06-14 12:26:57.734576	2025-06-14 12:26:57.734576	en
166	cG9MyPrsQTqTNKdsNboXkc:APA91bEQlgcgKoSQ5EovNflflCJuBKb0MXiiO1hrDB_VmIVBeOeDBjPzdaHT9_TdV2bI8E8W5veMQ4rPUpvsALTasI__C5zUarbTXXs8HSk0Mz-CNP-kxqU	\N	2025-06-20 21:28:10.096257	2025-06-20 21:28:10.096257	en
167	dnUL3_qyRAaboV4SMkkruX:APA91bFXFfruSC3-t0PlY3NaA7_RXt-6VN4Lj7nhfGcAk8SFffsXOpNT71KXTP6SPE5pQeMwr8m42us8ZpiOlFt1RZrXhYcUq25K_hesPPvGrHsg00o7gDg	\N	2025-06-21 17:04:07.763572	2025-06-21 17:04:07.763572	en
168	dIAUmedKRoKP_0OC1d1hRC:APA91bHE-YOjYbRrPOqKqOchhOLiJLC6HJ9IOJ7mm7t6UBhM1iN-Sor3d6nq9yO3A6TjII0cq9U_VftMwL9gMjwM0AbKa15yjbrSeLEgkrqPoRBezT45CZE	Chittor	2025-06-22 18:05:15.737042	2025-06-22 18:05:15.737042	en
169	eKjuQrJFRZ29q6nv8ZEIbO:APA91bGt4cD_5alvhqvGnrqchvAoRDhmSxgBNWajIazYvNq_daZEtah69WIKPCU7jtQLUSNnXjsue-loEWw3cVD-hdoESk-VqbdxugoR2sgngKSQ0Xm0wsI	\N	2025-06-22 19:56:02.961645	2025-06-22 19:56:02.961645	en
170	cTn37bOfRzG_pS-JeWTvaQ:APA91bFrd-CBxb5EeH5upVcKNRHzaug1PED6IZGzMkvjkgUoLy-liy50xBh5EGBrLnzgD4TQAmSKCKqWy3Z4sxCdTdndgBnB6aBROMIwWd6qK4ojg9uP2Cw	Chittor	2025-06-23 10:07:15.970022	2025-06-23 17:33:21.282932	hi
172	e27kNa0eSBa5RI1q6tVc4E:APA91bEPEbfTxSpHdRwtQkY5DIp94RZwntxHo16bDCWWuVIMIgvavoZGZTXd8xkAR8rq75j8TVSsBKkQZ9dfWYQBLi6qP_q4IIJdw6wpkMbnJTxFHE7ORBQ	Guntur	2025-06-29 13:55:09.388499	2025-06-29 14:14:23.022152	en
173	chazcQJDSNmBytIL30IeeM:APA91bFoQNb94XH83Kt2CeIN_7R7oKxVTIr5lIgMCQ4zeQ603aawkQn-tkcWWCzwlfoRr6gZkd3Q9lERj2yq8OvYgkdugewsYZaLtlQAadLje-wZVrC6l3w	\N	2025-06-29 14:57:12.381921	2025-06-29 15:52:21.523446	en
175	f8HuhF7SQUOmGiHF-bFuEv:APA91bHRrax3_Wd7J36JpJbHBfZDml61lhQdSgLkh4c31pqwbiIIOI9lcgSsn5wC050C8QkRV2PfEI_gG04suKoQIXPtlBIalgdFbjjlLocdolc-_BBu41w	\N	2025-06-29 19:09:39.306022	2025-07-23 09:49:42.402493	hi
178	ExponentPushToken[z5wR1GJ5LHp1LbcK5VblWn]	\N	2025-12-11 07:12:26.927844	2025-12-11 07:12:27.541428	en
177	f6La5DaaTv2Yaact2T-5aY:APA91bGWwoQE6vyeAlHWG97gJcBVonfqIsU4yXpNlU13RGjgOh5nH21E8g1BvaGuexcOSryPXO4sQzpq2Wx78DAcjm6dMqNF3UJHSzYaXGZY-A2qNNWLT2Q	\N	2025-10-22 13:02:59.797964	2026-02-22 08:54:31.884486	en
174	{"data":""}	\N	2025-06-29 18:30:09.637036	2026-02-23 09:51:44.815437	en
176	f3dDCkvIQo6DR6d9cfhl4Q:APA91bFqOp-g59n-nhnYJDtLtEQzwJ0FEFa1X-42PqTGKmDad5cjxVt6F4VukLh1Pebt3vCEcvKcUvIWqDixQkrwI0TtpX5LMYvi1qsMvQWfU-06Ti81i8g	\N	2025-10-20 08:34:26.823464	2025-10-20 08:34:27.317006	en
\.


--
-- Name: crop_paragraphs_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.crop_paragraphs_id_seq', 115, true);


--
-- Name: crops_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.crops_id_seq', 17, true);


--
-- Name: news_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.news_id_seq', 46, true);


--
-- Name: scheme_translations_id_seq; Type: SEQUENCE SET; Schema: public; Owner: yuvraj
--

SELECT pg_catalog.setval('public.scheme_translations_id_seq', 92, true);


--
-- Name: schemes_subsidies_id_seq; Type: SEQUENCE SET; Schema: public; Owner: yuvraj
--

SELECT pg_catalog.setval('public.schemes_subsidies_id_seq', 37, true);


--
-- Name: user_fcm_tokens_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.user_fcm_tokens_id_seq', 178, true);


--
-- Name: crop_paragraphs crop_paragraphs_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.crop_paragraphs
    ADD CONSTRAINT crop_paragraphs_pkey PRIMARY KEY (id);


--
-- Name: crops crops_name_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.crops
    ADD CONSTRAINT crops_name_key UNIQUE (name);


--
-- Name: crops crops_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.crops
    ADD CONSTRAINT crops_pkey PRIMARY KEY (id);


--
-- Name: news news_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.news
    ADD CONSTRAINT news_pkey PRIMARY KEY (id);


--
-- Name: scheme_translations scheme_translations_pkey; Type: CONSTRAINT; Schema: public; Owner: yuvraj
--

ALTER TABLE ONLY public.scheme_translations
    ADD CONSTRAINT scheme_translations_pkey PRIMARY KEY (id);


--
-- Name: schemes_subsidies schemes_subsidies_pkey; Type: CONSTRAINT; Schema: public; Owner: yuvraj
--

ALTER TABLE ONLY public.schemes_subsidies
    ADD CONSTRAINT schemes_subsidies_pkey PRIMARY KEY (id);


--
-- Name: scheme_translations unique_scheme_language; Type: CONSTRAINT; Schema: public; Owner: yuvraj
--

ALTER TABLE ONLY public.scheme_translations
    ADD CONSTRAINT unique_scheme_language UNIQUE (scheme_id, language_code);


--
-- Name: user_fcm_tokens user_fcm_tokens_fcm_token_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_fcm_tokens
    ADD CONSTRAINT user_fcm_tokens_fcm_token_key UNIQUE (fcm_token);


--
-- Name: user_fcm_tokens user_fcm_tokens_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_fcm_tokens
    ADD CONSTRAINT user_fcm_tokens_pkey PRIMARY KEY (id);


--
-- Name: idx_scheme_translations_language; Type: INDEX; Schema: public; Owner: yuvraj
--

CREATE INDEX idx_scheme_translations_language ON public.scheme_translations USING btree (language_code);


--
-- Name: idx_schemes_subsidies_type; Type: INDEX; Schema: public; Owner: yuvraj
--

CREATE INDEX idx_schemes_subsidies_type ON public.schemes_subsidies USING btree (type);


--
-- Name: user_fcm_tokens trigger_update_updated_at; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER trigger_update_updated_at BEFORE UPDATE ON public.user_fcm_tokens FOR EACH ROW EXECUTE FUNCTION public.update_updated_at_column();


--
-- Name: crop_paragraphs crop_paragraphs_crop_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.crop_paragraphs
    ADD CONSTRAINT crop_paragraphs_crop_id_fkey FOREIGN KEY (crop_id) REFERENCES public.crops(id) ON DELETE CASCADE;


--
-- Name: scheme_translations scheme_translations_scheme_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: yuvraj
--

ALTER TABLE ONLY public.scheme_translations
    ADD CONSTRAINT scheme_translations_scheme_id_fkey FOREIGN KEY (scheme_id) REFERENCES public.schemes_subsidies(id) ON DELETE CASCADE;


--
-- Name: TABLE crop_paragraphs; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.crop_paragraphs TO yuvraj;


--
-- Name: SEQUENCE crop_paragraphs_id_seq; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON SEQUENCE public.crop_paragraphs_id_seq TO yuvraj;


--
-- Name: TABLE crops; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.crops TO yuvraj;


--
-- Name: SEQUENCE crops_id_seq; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON SEQUENCE public.crops_id_seq TO yuvraj;


--
-- Name: TABLE news; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.news TO yuvraj;


--
-- Name: SEQUENCE news_id_seq; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON SEQUENCE public.news_id_seq TO yuvraj;


--
-- Name: TABLE user_fcm_tokens; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.user_fcm_tokens TO yuvraj;


--
-- Name: SEQUENCE user_fcm_tokens_id_seq; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON SEQUENCE public.user_fcm_tokens_id_seq TO yuvraj;


--
-- Name: DEFAULT PRIVILEGES FOR SEQUENCES; Type: DEFAULT ACL; Schema: public; Owner: postgres
--

ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA public GRANT ALL ON SEQUENCES TO yuvraj;


--
-- Name: DEFAULT PRIVILEGES FOR TABLES; Type: DEFAULT ACL; Schema: public; Owner: postgres
--

ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA public GRANT ALL ON TABLES TO yuvraj;


--
-- PostgreSQL database dump complete
--

\unrestrict 9vDLsLVZHi0uULnuc82pZvm2dmUDwuLj390VIA21briQnEARDzvouMHxBeua8aK

