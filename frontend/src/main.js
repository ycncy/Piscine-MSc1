import './assets/main.css'
import { createApp } from 'vue'
import App from '@/App.vue'
import Router from "@/Router";
import Store from "@/Store";

const app = createApp(App)

app.use(Router)
app.use(Store)

app.mount('#app')
