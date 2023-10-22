<template>
  <div>
    <h1>Customers List</h1>
    <div v-for="customer in customers" :key="customer.id">
      <p>{{ customer.id }}. {{ customer.name }} [{{ customer.tier }}]</p>
      <p>Total Spent: USD {{ customer.total_spent }}</p>
      <button @click="showDetails(customer.id)">Detail</button>
      <br />
    </div>
    <div>
      <h1>Customers Detail</h1>
      <div v-if="showCustomerDetail">
        <p>Name: {{ customerInfo.customer_name }}</p>
        <p>Tier: {{ customerInfo.tier }}</p>
        <p>Start Date Current Tier: {{ customerInfo.date_of_current_tier_trx }}</p>
        <p>Current Total Spent:{{ customerInfo.current_tier_total_spent }} </p>
        <p>Next Tier: {{ customerInfo.next_tier }}</p>
        <p>Need More Spent to Next Tier: {{ customerInfo.total_spent_need_to_upgrade }} </p>
        <div id="myProgress">
          <div id="myBar" :style="{ width: width + '%' }"></div>
        </div>
        <p>Downgrade Tier: {{ customerInfo.before_tier }}</p>
        <p>Need More Spent to Maintain Tier: {{ customerInfo.total_spent_to_maintain_current_tier }}</p>
        <p>Reset Date Tier: {{ customerInfo.reset_tier_date }}</p>
      </div>
    </div>
    <div>
      <h1>Order List</h1>
      <div v-for="order in orderList" :key="orderList.id">
        <p>No. Transaction: {{ order.id }}</p>
        <p>Total Order: {{ order.total_order }}</p>
        <p>Date Order: {{ order.created_at }}</p>
        <br />
      </div>
    </div>
  </div>
</template>

<script setup>
  import {ref, onMounted} from 'vue';
  const customers = ref([]);
  const customerInfo = ref([]);
  const orderList = ref([]);
  var width = 0;
  const showCustomerDetail = ref(false);
  const API_URL = "http://localhost:3000/customers"

  onMounted(async() => {
    const res = await fetch(API_URL)
    customers.value = await res.json()
  })

  const showDetails = (customerId) => {
    showCustomerInfo(customerId);
    showOrderList(customerId);
  };

  const showCustomerInfo = async (customerId) => {
    const infoRes = await fetch(`${API_URL}/${customerId}`);
    customerInfo.value = await infoRes.json();

    if (customerInfo.value.next_tier == "GOLD") {
      width = ((500 - customerInfo.value.total_spent_need_to_upgrade)/500) * 100;
    }
    else if (customerInfo.value.next_tier == "SILVER") {
      width = ((100 - customerInfo.value.total_spent_need_to_upgrade));
    }

    showCustomerDetail.value = true;
  };

  const showOrderList = async (customerId) => {
    const infoRes = await fetch(`${API_URL}/${customerId}/current_order_history`);
    orderList.value = await infoRes.json();
  };
</script>

<style scoped>
p {
  text-align: left;
}

#myProgress {
  width: 100%;
  background-color: grey;
}

#myBar {
  width: 1%;
  height: 20px;
  background-color: green;
}
</style>