<template>
        <aside>
            <div class="sidebar">
                <div class="sidebar-header">
                    <h3>Menu</h3>
                </div>
                <ul class="sidebar-list">
                    <li class="sidebar-list-item">
                        <select v-model="selected">
                            <option v-for="option in options" :value="option.value">
                                {{ option.text }}
                            </option>
                        </select>

<div>Selected: {{ selected }}</div>
                    </li>
                    <li class="sidebar-list-item">
                        <router-link to="/workingtimes">Working times</router-link>
                    </li>
                    <li class="sidebar-list-item">
                        <router-link to="/users">Users</router-link>
                    </li>
                </ul>
            </div>  
        </aside>
</template>


<script>
import {users_service} from "@/services/users.service.js"
export default {
    name: 'Sidebar',
    data() {
        return {
            users_list: null,
        };
    },
    methods: {
        getUsers: function () {
            users_service.get_all_users().then((result) => {
            console.log( result.data );
            this.users_list = result.data;
        });
        },
    },
    created() {
        this.getUsers();
    },
}

</script>