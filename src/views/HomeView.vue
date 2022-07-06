<script>
import axios from 'axios'
export default {
  data() {
    return {
      usersList: [],
      userToAdd:{

      },
      userToEdit: {
        firstname: '',
        middlename: '',
        lastname: '',
        age: '',
        id: ''
      },
      showEditModal: false,
    }
  },
  async created(){
    await this.getUsers()
  },
  methods:{
    async addUser(){
      const { firstname, middlename, lastname, age } = this.userToAdd
      try{
        const res = await axios({
          method: 'POST',
          url: 'http://172.16.4.153:5000/getUser',
          headers: {},
          data: {
            firstName: firstname,
            middleName: middlename,
            lastName: lastname,
            age: age
          }
        })
        console.log('src\views\HomeView.vue ~ HomeView ~ Line 21 ~ res: ', res)
        console.log('==============================================================================')
        console.log('res.config.data: ', JSON.parse(res.config.data));
        console.log('==============================================================================')
        // let id = 0
        // this.usersList.forEach(x=>{
        //   if(id>x) id = x
        // })
        // console.log('==============================================================================')
        // console.log('id: ', id);
        // console.log('==============================================================================')
        // let x = JSON.parse(res.config.data)
        // x = {...x, userinfo_id: id+1}
        // this.usersList = {...this.usersList, x}
        this.getUsers()
      } catch(err) {
        console.log('src\views\HomeView.vue ~ HomeView ~ Line 21 ~ err: ', err)
      }
    },
    async deleteUser(id){
      try{
        const res = await axios({
          method: 'DELETE',
          url: `http://172.16.4.153:5000/getUser/${id}`,
          headers: {},
        })
        console.log('src\views\HomeView.vue ~ HomeView ~ Line 59 ~ res: ', res)
        this.usersList = this.usersList.filter(x=>x.userinfo_id != id)
      } catch(err) {
        console.log('src\views\HomeView.vue ~ HomeView ~ Line 59 ~ err: ', err)
      }
    },
    openEditModal(user){
      console.log('==============================================================================')
      console.log('user: ', user);
      console.log('==============================================================================')
      this.showEditModal = true
      this.userToEdit.firstname = user.firstname
      this.userToEdit.middlename = user.middlename
      this.userToEdit.lastname = user.lastname
      this.userToEdit.age = user.age
      this.userToEdit.id = user.userinfo_id
    },
    async editUser(){
      const { firstname, middlename, lastname, age, id } = this.userToEdit
      try{
        const res = await axios({
          method: 'PUT',
          url: `http://172.16.4.153:5000/getUser/${id}`,
          headers: {},
          data: {
            firstName: firstname,
            middleName: middlename,
            lastName: lastname,
            age: age
          }
        })
        console.log('==============================================================================')
        console.log('this.userToEdit: ', this.userToEdit);
        console.log('==============================================================================')
        console.log('src\views\HomeView.vue ~ HomeView ~ Line 59 ~ res: ', res)
        let a = JSON.parse(res.config.data);
        this.usersList.forEach(x=>{
          if(x.userinfo_id == id){
            x.age = a.age,
            x.firstname = a.firstName,
            x.middlename = a.middleName
            x.lastname = a.lastName
          }
        })
        this.showEditModal = false
      } catch(err) {
        console.log('src\views\HomeView.vue ~ HomeView ~ Line 59 ~ err: ', err)
      }
    },
    async getUsers(){
      try{
        const res = await axios({
          method: 'GET',
          url: 'http://172.16.4.153:5000/getUser',
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
        <input v-model="userToAdd.firstname" class="border-2 rounded-md py-1 px-3" type="text" placeholder="First Name">
        <input v-model="userToAdd.middlename" class="border-2 rounded-md py-1 px-3" type="text" placeholder="Middle Name">
        <input v-model="userToAdd.lastname" class="border-2 rounded-md py-1 px-3" type="text" placeholder="Last Name">
        <input v-model="userToAdd.age" class="border-2 rounded-md py-1 px-3" type="number" placeholder="Age">
        <button @click="addUser()" class="px-3 py-1 bg-green-600 text-white rounded-md">Add</button>
      </div>
      <div class="right flex flex-col w-1/2 justify-center px-10">
        <div v-for="user in usersList" :key="user.userinfo_id" >
          <p>{{ user.firstname?user.firstname:user.firstName }} {{ user.middlename?user.middlename:user.middleName }} {{ user.lastname?user.lastname:user.lastName }}, {{user.age}} years of age
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
        <input v-model="userToEdit.firstname" class="border-2 rounded-md py-1 px-3" type="text" placeholder="First Name">
        <input v-model="userToEdit.middlename" class="border-2 rounded-md py-1 px-3" type="text" placeholder="Middle Name">
        <input v-model="userToEdit.lastname" class="border-2 rounded-md py-1 px-3" type="text" placeholder="Last Name">
        <input v-model="userToEdit.age" class="border-2 rounded-md py-1 px-3" type="number" placeholder="Age">
        <button @click="editUser" class="px-3 py-1 bg-green-600 text-white rounded-md">Save</button>
        <button @click="showEditModal = false" class="px-3 py-1 bg-slate-600 text-white rounded-md">Close</button>
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