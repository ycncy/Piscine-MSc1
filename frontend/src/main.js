import './assets/index.css'
import { createApp } from 'vue'
import App from '@/App.vue'
import router from "@/Router";
import Store from "@/Store";

const app = createApp(App)

app.use(router)
app.use(Store)

app.mount('#app')