<script>
import axios from 'axios'
export default {
  data() {
    return {
      usersList: [],
      firstnameToEdit: "",
      middlenameToEdit: "",
      lastnameToEdit: "",
      ageToEdit: "",
      showEditModal: false,
      firstnameToAdd: "",
      middlenameToAdd: "",
      lastnameToAdd: "",
      ageToAdd: ""
    }
  },
  async created(){
    await this.getUsers()
  },
  methods:{
    async addUser(){
      try{
        const res = await axios({
          method: 'POST',
          url: 'http://localhost:5000/getUser',
          headers: {},
          data: {
            firstName: this.firstnameToAdd,
            middleName: this.middlenameToAdd,
            lastName: this.lastnameToAdd,
            age: this.ageToAdd
          }
        })
        console.log('src\views\HomeView.vue ~ HomeView ~ Line 21 ~ res: ', res)
        console.log('==============================================================================')
        console.log('res.config.data: ', JSON.parse(res.config.data));
        console.log('==============================================================================')
        this.getUsers()
      } catch(err) {
        console.log('src\views\HomeView.vue ~ HomeView ~ Line 21 ~ err: ', err)
      }
    },
    async deleteUser(id){
      try{
        const res = await axios({
          method: 'DELETE',
          url: `http://localhost:5000/getUser/${id}`,
          headers: {},
        })
        console.log('src\views\HomeView.vue ~ HomeView ~ Line 59 ~ res: ', res)
        this.getUsers()
      } catch(err) {
        console.log('src\views\HomeView.vue ~ HomeView ~ Line 59 ~ err: ', err)
      }
    },
    openEditModal(user){
      console.log('==============================================================================')
      console.log('user: ', user);
      console.log('==============================================================================')
      this.showEditModal = true
      this.firstnameToEdit = user.firstname
      this.middlenameToEdit = user.middlename
      this.lastnameToEdit = user.lastname
      this.ageToEdit = user.age
      this.userIndex = user.userinfo_id
    },
    async editUser(){
      try{
        const res = await axios({
          method: 'PUT',
          url: `http://localhost:5000/getUser/${this.userIndex}`,
          headers: {},
          data: {
            firstName: this.firstnameToEdit,
            middleName: this.middlenameToEdit,
            lastName: this.lastnameToEdit,
            age: this.ageToEdit
          }
        })
        console.log('src\views\HomeView.vue ~ HomeView ~ Line 59 ~ res: ', res)
        this.getUsers()
        this.showEditModal = false
      } catch(err) {
        console.log('src\views\HomeView.vue ~ HomeView ~ Line 59 ~ err: ', err)
      }
    },
    async getUsers(){
      try{
        const res = await axios({
          method: 'GET',
          url: 'http://localhost:5000/getUser',
        })
        console.log('src\views\HomeView.vue ~ HomeView ~ Line 2 ~ res: ', res)
        this.usersList = res.data
      } catch(err) {
        console.log('src\views\HomeView.vue ~ HomeView ~ Line 2 ~ err: ', err)
      }
    }
  }
}
</script>

<template>
  <div class="main mt-10">
    <h1 class="text-green-500 font-semibold text-center mb-10">Register a User Form</h1>
    <div class="flex flex-row w-[100vw] justify-center align-middle">
      <div class="left flex flex-col gap-2 w-1/2 p-36 justify-center items-center">
        <input v-model="firstnameToAdd" class="border-2 rounded-md py-1 px-3" type="text" placeholder="First Name">
        <input v-model="middlenameToAdd" class="border-2 rounded-md py-1 px-3" type="text" placeholder="Middle Name">
        <input v-model="lastnameToAdd" class="border-2 rounded-md py-1 px-3" type="text" placeholder="Last Name">
        <input v-model="ageToAdd" class="border-2 rounded-md py-1 px-3" type="number" placeholder="Age">
        <button @click="addUser()" class="px-3 py-1 bg-green-600 text-white rounded-md">Add</button>
      </div>
<<<<<<< HEAD
      <div class="right flex flex-col w-1/2 justify-center px-10">
        <div v-for="user in usersList" :key="user.userinfo_id" >
          <p>{{ user.firstname }} {{ user.middlename }} {{ user.lastname }}, {{user.age}} years of age
            <span class="text-sm text-slate-500">
              <button class="mr-2 text-green-500 underline" @click="openEditModal(user)">edit</button>
              <button class="text-red-400 underline" @click="deleteUser(user.userinfo_id)">delete</button>
            </span>
          </p>
        </div>
      </div>
    </div>
    <div v-if="showEditModal" class="modal grid place-items-center">
      <div class="flex flex-col gap-3 bg-white p-5 rounded-md">
        <input v-model="firstnameToEdit" class="border-2 rounded-md py-1 px-3" type="text" placeholder="First Name">
        <input v-model="middlenameToEdit" class="border-2 rounded-md py-1 px-3" type="text" placeholder="Middle Name">
        <input v-model="lastnameToEdit" class="border-2 rounded-md py-1 px-3" type="text" placeholder="Last Name">
        <input v-model="ageToEdit" class="border-2 rounded-md py-1 px-3" type="number" placeholder="Age">
        <button @click="editUser" class="px-3 py-1 bg-green-600 text-white rounded-md">Save</button>
        <button @click="showEditModal = false" class="px-3 py-1 bg-slate-600 text-white rounded-md">Close</button>
=======
      <div class="flex w-1/2 justify-center items-center">
        no data to display
>>>>>>> e03255f70d2ad142ae2dcfe275acf0c06706873c
      </div>
    </div>
  </div>
</template>

<style scoped>
.modal{
  position: fixed;
  inset:  0 0 0 0;
  background: rgba(0, 0, 0, 0.556);
}
</style>