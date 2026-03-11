<#
.SYNOPSIS
    Demonstrates creating a PSObject with multiple NoteProperty members.

.DESCRIPTION
    Creates a plain PSObject and adds NoteProperty members using Add-Member, including
    a Name property and multiple Maps properties. Useful as a reference for building
    objects with repeated or multiple property names.

.NOTES
    Author: David Cook
    - Note: Adding multiple NoteProperty members with the same name (Maps) will cause
      errors after the first; use a collection/array property instead for multiple values.

.EXAMPLE
    .\Untitled2.ps1
    Creates $obj with Name='Giving' and attempts to add multiple Maps properties.
#>




$obj = New-Object psobject
Add-Member -InputObject $obj -MemberType NoteProperty -Name Name -Value "Giving"


Add-Member -InputObject $obj -MemberType NoteProperty -Name Maps -Value "Kansashealthsystem"
Add-Member -InputObject $obj -MemberType NoteProperty -Name Maps -Value "KUCancer"
Add-Member -InputObject $obj -MemberType NoteProperty -Name Maps -Value "kumed"
Add-Member -InputObject $obj -MemberType NoteProperty -Name Maps -Value "kuphysicians"
Add-Member -InputObject $obj -MemberType NoteProperty -Name Maps -Value "referral"
Add-Member -InputObject $obj -MemberType NoteProperty -Name Maps -Value "Sportsmedicine"
Add-Member -InputObject $obj -MemberType NoteProperty -Name Maps -Value "Turningpointkc"
Add-Member -InputObject $obj -MemberType NoteProperty -Name Maps -Value "wellness"